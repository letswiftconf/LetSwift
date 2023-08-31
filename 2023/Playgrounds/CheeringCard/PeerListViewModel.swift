//
//  PeerListViewModel.swift
//  LetSwift
//
//  Created by Noah on 2022/11/26.
//

import Combine
import Foundation
import MultipeerConnectivity
import NearbyInteraction

final class PeerListViewModel: ObservableObject {
    // MARK: - properties
    
    private var peerConnectionController: PeerConnectionController
    @Published private(set) var isNearbySessionEstablished: Bool = false
    @Published private(set) var distanceToPeerDevice: String = ""
    @Published private(set) var peerName: String = ""
    @Published private(set) var peers: [Peer] = []
    @Published var isShowAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(peerConnectionController: PeerConnectionController) {
        self.peerConnectionController = peerConnectionController
        self.bindToPeerConnectionController()
    }
    
    // MARK: - func
    
    func startPeerConnectionController() {
        self.peerConnectionController.startPeerConnetionController()
    }
    
    func stopPeerConnectionController() {
        self.peerConnectionController.stopPeerConenctionController()
    }
    
    func invite(to peerID: MCPeerID) {
        self.peerConnectionController.disconnectToPeerDevice()
        self.peerConnectionController.invite(to: peerID)
    }
    
    func disconnectToPeerDevice() {
        self.peerConnectionController.disconnectToPeerDevice()
    }
    
    func setIsSupportedNearbyInteraction() {
        self.isShowAlert = NearbyInteractionManager.isSupportedNearbyInteraction() == false
    }
}

private extension PeerListViewModel {
    // MARK: - private func
    
    func bindToPeerConnectionController() {
        self.peerConnectionController.$connectedPeer
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] peer in
            self?.peerName = peer?.displayName ?? ""
        }).store(in: &self.cancellables)
        
        self.peerConnectionController.$peers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] peers in
                self?.peers = peers
            }.store(in: &self.cancellables)
        
        self.peerConnectionController.$isNISessionEstablished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isNISessionEstablished in
                self?.isNearbySessionEstablished = isNISessionEstablished
            }.store(in: &self.cancellables)
        
        self.peerConnectionController.$distanceToPeerDevice
            .receive(on: DispatchQueue.main)
            .sink { [weak self] distanceToPeerDevice in
                self?.setDistanceToPeerDevice(from: distanceToPeerDevice)
            }.store(in: &self.cancellables)
    }
    
    func setDistanceToPeerDevice(from distanceToPeerDevice: Float?) {
        self.distanceToPeerDevice = String(
            format: "%0.2f",
            distanceToPeerDevice ?? 0.0
        )
    }
}
