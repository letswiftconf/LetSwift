//
//  PeerConnectionController.swift
//  LetSwift
//
//  Created by Noah on 2022/11/24.
//

import Combine
import Foundation
import MultipeerConnectivity
import NearbyInteraction

/// NearbyInteractionManager와 MultipeerConnectivity의 상호작용을 관리하는 클래스입니다.
final class PeerConnectionController {
    // MARK: - properties
    
    /// 현재 주변에 발견된 peer들을 저장하고 있는 배열입니다.
    @Published var peers: [Peer]
    /// NearbyInteraction Session의 연결 상태를 나타냅니다.
    @Published var isNISessionEstablished: Bool
    @Published var distanceToPeerDevice: Float?
    @Published var connectedPeer: Peer?
    private let nearbyInteractionManager: NearbyInteractionManager
    private let multipeerConnectivityManager: MultipeerConnectivityManager
    private var cancellables: Set<AnyCancellable>
    private var isTokenSharedWithPeer: Bool
    
    // MARK: - init
    
    init() {
        self.peers = []
        self.isNISessionEstablished = false
        self.isTokenSharedWithPeer = false
        self.nearbyInteractionManager = NearbyInteractionManager()
        self.multipeerConnectivityManager = MultipeerConnectivityManager()
        self.cancellables = Set<AnyCancellable>()
        self.bindToPeerConnectionManager()
        self.bindToNearbyInteractionManager()
    }
    
    // MARK: - func
    
    /// PeeerConnectionController를 시작합니다.
    /// > 이전에 연결된 session이 있다면 연결을 해제한 후에 사용하기위해 ``self.multipeerConnectivityManager.disconnectSession()``을 호출합니다.
    func startPeerConnetionController() {
        self.multipeerConnectivityManager.disconnectSession()
        self.startMultiPeerConnectionManager()
        self.startNearbyInteractionManager()
    }
    
    /// PeerConnectionController를 종료합니다.
    func stopPeerConenctionController() {
        self.stopMultiPeerConnectionManager()
        self.stopNearbyInteractionManager()
    }
    
    /// peer를 MultipeerConnectivity session에 초대합니다.
    func invite(to peerID: MCPeerID) {
        self.multipeerConnectivityManager.invite(to: peerID)
    }
    
    /// peer와의 연결을 해제합니다.
    func disconnectToPeerDevice() {
        self.disconnectMCSession()
        self.disconnectNISession()
    }
    
    deinit {
        self.stopPeerConenctionController()
        self.peers.removeAll()
    }
}

private extension PeerConnectionController {
    // MARK: - private func
    
    func connected(peerID: MCPeerID) {
        self.connectedPeer = Peer(id: peerID)
    }
    
    /// MCSession을 종료시키기 위해 사용합니다.
    func disconnectMCSession() {
        self.connectedPeer = nil
        self.multipeerConnectivityManager.disconnectSession()
    }
    
    /// NISession을 종료시키기 위해 사용합니다.
    func disconnectNISession() {
        self.nearbyInteractionManager.sessionInvalidate()
        self.isNISessionEstablished = false
        self.isTokenSharedWithPeer = false
    }
    
    func startNearbyInteractionManager() {
        self.nearbyInteractionManager.startNearbyInteractionSession()
    }
    
    func startMultiPeerConnectionManager() {
        self.multipeerConnectivityManager.startMultiPeerConnectionManager()
    }
    
    func stopMultiPeerConnectionManager() {
        self.connectedPeer = nil
        self.multipeerConnectivityManager.stopMultiPeerConnectionManager()
    }
    
    func stopNearbyInteractionManager() {
        self.isNISessionEstablished = false
        self.nearbyInteractionManager.sessionInvalidate()
    }
    
    /// NearybyInteraction 프레임워크를 사용하기 위해 연결된 peer에게 MultiPeerConenctivityManager를 이용해 DiscoveryToken을 전송합니다.
    func sendDiscoveryToken(to peerID: MCPeerID) {
        guard let discoveryToken = self.nearbyInteractionManager.localDiscoveryToken,
              let encodedData = try? NSKeyedArchiver.archivedData(
                withRootObject: discoveryToken,
                requiringSecureCoding: true
              ) else {
            fatalError("Unexpectedly failed to encode discovery token.")
        }
        
        self.multipeerConnectivityManager.send(with: encodedData, to: peerID)
    }
    
    /// peer에게 받은 DiscoveryToken을 이용해 NearbyInteraction Session을 시작합니다.
    func received(with data: Data, from peerID: MCPeerID) {
        guard let discoveryToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data)
        else {
            fatalError("Unexpectedly failed to decode discovery token.")
        }
        
        if self.isTokenSharedWithPeer == false {
            self.sendDiscoveryToken(to: peerID)
            self.isTokenSharedWithPeer = true
        }
        self.nearbyInteractionManager.setPeerDiscoveryToken(discoveryToken)
        self.nearbyInteractionManager.initiateNearbySession()
    }
    
    /// 발견된 peer를 peers 배열에 추가합니다.
    func received(peerID: MCPeerID) {
        print("print peer founded: \(peerID.displayName)")
        if self.peers.contains(where: { peer in
            peer.id == peerID
        }) == false {
            self.peers.append(Peer(id: peerID))
        }
    }
    
    /// 사라진 peer를 peers배열에서 삭제합니다.
    func losted(peerID: MCPeerID) {
        guard let index = self.peers.firstIndex(where: { peer in
            peer.id == peerID
        })
        else { return }
        self.peers.remove(at: index)
    }
    
    /// 연결된 peer와의 거리를 업데이트 합니다.
    func updateDistanceToPeerDevice(with nearbyObject: NINearbyObject) {
        self.distanceToPeerDevice = nearbyObject.distance
    }
    
    /// PeerConnectionManager의 이벤트를 전달받기 위해 PeerConnectionManager의 프로퍼티와 바인딩합니다.
    func bindToPeerConnectionManager() {
        self.multipeerConnectivityManager.$receivedPeerID
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] peerID in
                self?.received(peerID: peerID)
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.peerLosted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] peerID in
                self?.losted(peerID: peerID)
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.peerConnected
            .sink { [weak self] peerID in
                self?.connected(peerID: peerID)
                self?.sendDiscoveryToken(to: peerID)
                self?.nearbyInteractionManager.initiateNearbySession()
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.peerNotConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.disconnectToPeerDevice()
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.dataReceived
            .sink { [weak self] (peerID, data) in
                self?.received(with: data, from: peerID)
            }.store(in: &self.cancellables)
    }
    
    /// NearbyInteraction의 이벤트를 전달받기 위해 PeerConnectionManager의 프로퍼티와 바인딩합니다.
    func bindToNearbyInteractionManager() {
        self.nearbyInteractionManager.$updatedNearbyObject
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] nearbyObject in
                self?.updateDistanceToPeerDevice(with: nearbyObject)
            }.store(in: &self.cancellables)
        
        self.nearbyInteractionManager.sessionEstablished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.isNISessionEstablished = true
            }.store(in: &self.cancellables)
    }
}
