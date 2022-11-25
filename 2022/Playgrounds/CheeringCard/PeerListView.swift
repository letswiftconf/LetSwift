//
//  PeerListView.swift
//  LetSwift
//
//  Created by Noah on 2022/11/26.
//

import SwiftUI

struct PeerListView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PeerListViewModel
    
    init(viewModel: PeerListViewModel) {
        self.viewModel = viewModel
        UICollectionView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PeerListView_Previews: PreviewProvider {
    static var previews: some View {
        PeerListView(
            viewModel: PeerListViewModel(
                peerConnectionController: PeerConnectionController()
            )
        )
    }
}
