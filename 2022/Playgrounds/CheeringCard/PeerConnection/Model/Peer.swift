//
//  Peer.swift
//  LetSwift
//
//  Created by Noah on 2022/11/24.
//

import Foundation
import MultipeerConnectivity

struct Peer: Identifiable {
    let id: MCPeerID
    let displayName: String
    
    init(id: MCPeerID) {
        self.id = id
        self.displayName = id.displayName
    }
}
