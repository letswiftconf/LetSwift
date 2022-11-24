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
    }
}
