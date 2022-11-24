//
//  NearbyInteractionManager.swift
//  LetSwift
//
//  Created by Noah on 2022/11/24.
//

import Combine
import Foundation
import NearbyInteraction
import UIKit

final class NearbyInteractionManager: NSObject {
    // MARK: - properties
    
    private var session: NISession?
    private var peerDiscoveryToken: NIDiscoveryToken?
    private(set) var localDiscoveryToken: NIDiscoveryToken?
    @Published var updatedNearbyObject: NINearbyObject?
    let sessionEstablished: PassthroughSubject<Void, Never>
    
    override init() {
        self.sessionEstablished = PassthroughSubject()
        super.init()
        self.startNearbyInteractionSession()
    }
    
    // MARK: - func
    
    /// NISession을 initiate합니다.
    func initiateNearbySession() {
        guard let peerDiscoveryToken
        else { return }
        
        let configuration = NINearbyPeerConfiguration(peerToken: peerDiscoveryToken)
        self.session?.run(configuration)
        self.sessionEstablished.send()
    }
    
    /// NISession을 무효화합니다.
    func sessionInvalidate() {
        self.session?.invalidate()
    }
    
    /// NearbyInteractionSession을 시작합니다.
    func startNearbyInteractionSession() {
        /// 이전 세션이 있다면 세션을 종료합니다.
        self.sessionInvalidate()
        self.session = NISession()
        self.localDiscoveryToken = self.session?.discoveryToken
        self.setNearbyInteractionSessionDelegate()
    }
}

private extension NearbyInteractionManager {
    // MARK: - private func
    func setNearbyInteractionSessionDelegate() {
        self.session?.delegate = self
    }
}
