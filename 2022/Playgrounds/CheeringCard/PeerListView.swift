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
        ZStack {
            List {
                if self.viewModel.isNearbySessionEstablished {
                    Section {
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "person.circle")
                                Text("\(self.viewModel.peerName) 님과의 거리")
                                    .fontWeight(.bold)
                                Spacer()
                                Button {
                                    self.viewModel.disconnectToPeerDevice()
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                }
                            }
                            HStack {
                                Text(
                                    "\(self.viewModel.distanceToPeerDevice)"
                                )
                                .font(.title)
                                .fontWeight(.bold)
                                Text("m")
                                Spacer()
                            }
                        }
                    }
                }
                Section(
                    header: HStack(spacing: 8) {
                        Text("나와 같은 응원카드를 가진 동료")
                        Spacer()
                        ProgressView()
                    }
                ) {
                    ForEach(self.viewModel.peers, id: \.id) { peer in
                        HStack {
                            Text(peer.displayName)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "arrowshape.turn.up.right.fill")
                        }
                        .onTapGesture {
                            self.viewModel.invite(to: peer.id)
                        }
                        .listRowBackground(Color.backgroundCell)
                    }
                }
            }
            .background(Color.backgroundBlack)
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                self.viewModel.startPeerConnectionController()
            }
            .onDisappear {
                self.viewModel.stopPeerConnectionController()
            }
        }
        .navigationTitle("동료 찾기")
        .navigationBarTitleDisplayMode(.large)
        .alert(isPresented: self.$viewModel.isShowAlert) {
            Alert(title: Text("알림"),
                  message: Text("""
Nearby Interaction을 이용한
동료찾기 기능은 iPhone11 이상부터 사용가능합니다.
"""
                               ),
                  dismissButton: .default(
                    Text("확인"),
                    action: {
                        self.dismiss()
                    }
                  )
            )
        }
        .onAppear {
            self.viewModel.setIsSupportedNearbyInteraction()
        }
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
