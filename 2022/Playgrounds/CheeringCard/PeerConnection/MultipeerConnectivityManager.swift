//
//  MultipeerConnectivityManager.swift
//  LetSwift
//
//  Created by Noah on 2022/11/24.
//

import Combine
import Foundation
import MultipeerConnectivity

final class MultipeerConnectivityManager: NSObject {
    // MARK: - properties
    
    /// 응원카드의 타입이 같은 사용자와의 연결을 위한 필드입니다.
    private let cheeringCardType: String
    private let session: MCSession
    private let localPeerId: MCPeerID
    @Published var receivedPeerID: MCPeerID?
    private let nearbyServiceBrowser: MCNearbyServiceBrowser
    private let nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    let peerConnected: PassthroughSubject<MCPeerID, Never>
    let peerNotConnected: PassthroughSubject<MCPeerID, Never>
    let peerLosted: PassthroughSubject<MCPeerID, Never>
    let dataReceived: PassthroughSubject<(MCPeerID, Data), Never>
    
    override init() {
        let serviceType = "letswift"
        self.cheeringCardType = MultipeerConnectivityManager.getCheeringCardType()
        
        self.localPeerId = MCPeerID(
            displayName: MultipeerConnectivityManager.getUserName()
        )
        self.session = MCSession(
            peer: self.localPeerId,
            securityIdentity: nil,
            encryptionPreference: .none
        )
        self.nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
            peer: self.localPeerId,
            discoveryInfo: [self.cheeringCardType: self.cheeringCardType],
            serviceType: serviceType
        )
        self.nearbyServiceBrowser = MCNearbyServiceBrowser(
            peer: self.localPeerId,
            serviceType: serviceType
        )
        self.peerConnected = PassthroughSubject()
        self.peerNotConnected = PassthroughSubject()
        self.peerLosted = PassthroughSubject()
        self.dataReceived = PassthroughSubject()
        super.init()
        self.setDelegation()
    }
}

private extension MultipeerConnectivityManager {
    // MARK: - private func
    
    func setDelegation() {
        self.session.delegate = self
        self.nearbyServiceAdvertiser.delegate = self
        self.nearbyServiceBrowser.delegate = self
    }
    
    static func getCheeringCardType() -> String {
        guard let cheeringCardCategory = SharedPreference.shared.cheeringCard?.category
        else {
            return "none"
        }
        
        return cheeringCardCategory.utf8EncodedString()
    }
    
    static func getUserName() -> String {
        guard let userName = SharedPreference.shared.cheeringCard?.name
        else {
            return UIDevice.current.name
        }
        
        return userName
    }
}

extension MultipeerConnectivityManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        
        guard
            let window = windowScene?.windows.first,
            let context = context,
            let peerName = String(data: context, encoding: .utf8)
        else { return }
    
        let title = "\(peerName)와 연결"
        let message = "\(peerName)와 연결하시겠습니까?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            invitationHandler(true, self.session)
        })
        window.rootViewController?.present(alertController, animated: true)
    }
}

extension MultipeerConnectivityManager: MCNearbyServiceBrowserDelegate {
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String : String]?
    ) {
        guard let identityValue = info?[self.cheeringCardType] else {
            return
        }
        if identityValue == self.cheeringCardType {
            self.receivedPeerID = peerID
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        self.peerLosted.send(peerID)
    }
}

extension MultipeerConnectivityManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            self.peerConnected.send(peerID)
        case .notConnected:
            self.peerNotConnected.send(peerID)
            print("Not connected: \(peerID.displayName)")
        case .connecting:
            print("Connecting to: \(peerID.displayName)")
        @unknown default:
            print("Unknown state: \(state)")
        }
    }
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        self.dataReceived.send((peerID, data))
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String,fromPeer peerID: MCPeerID) {}
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
}
