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
