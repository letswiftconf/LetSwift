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
}

private extension PeerConnectionController {
    // MARK: - private func
    
    func connected(peerID: MCPeerID) {
        self.connectedPeer = Peer(id: peerID)
    }
    
    /// PeerConnectionManager의 이벤트를 전달받기 위해 PeerConnectionManager의 프로퍼티와 바인딩합니다.
    func bindToPeerConnectionManager() {
        self.multipeerConnectivityManager.$receivedPeerID
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] peerID in
                
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.peerLosted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] peerID in
                
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.peerConnected
            .sink { [weak self] peerID in
                self?.connected(peerID: peerID)
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.peerNotConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                
            }.store(in: &self.cancellables)
        
        self.multipeerConnectivityManager.dataReceived
            .sink { [weak self] (peerID, data) in
                
            }.store(in: &self.cancellables)
    }
    
    /// NearbyInteraction의 이벤트를 전달받기 위해 PeerConnectionManager의 프로퍼티와 바인딩합니다.
    func bindToNearbyInteractionManager() {
        self.nearbyInteractionManager.$updatedNearbyObject
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] nearbyObject in
                
            }.store(in: &self.cancellables)
        
        self.nearbyInteractionManager.sessionEstablished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                
            }.store(in: &self.cancellables)
    }
}
