//
//  TimetableView.swift
//  LetSwift-watchOS Watch App
//
//  Created by Coby on 11/25/24.
//

import SwiftUI
import WatchKit

struct TimetableView: View {
    @State private var viewModel = WatchSessionViewModel()
    @State private var selectedSession: SessionItem?
    
    var body: some View {
        NavigationStack {
            sessionList
                .navigationTitle(viewModel.currentTrack.displayName)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            viewModel.toggleTrack()
                        } label: {
                            Label("track", systemImage: viewModel.currentTrack.buttonText.lowercased() + ".circle")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
        }
        .sheet(item: $selectedSession) { session in
            SessionDetailView(session: session) {
                selectedSession = nil
            }
        }
        .task {
            await viewModel.loadSessionsOnce()
        }
//        ZStack {
//            VStack(spacing: 0) {
//                // Navigation bar
//                navigationBar
//                
//                // Session list
//                sessionList
//            }
//            .padding(.top, 20)
//            .edgesIgnoringSafeArea(.all)
//            
//            // Popup overlay
//            if let session = selectedSession {
//                SessionDetailView(session: session, dismiss: {
//                    selectedSession = nil
//                })
//                .zIndex(1)
//                .edgesIgnoringSafeArea(.all)
//            }
//        }
//        .background(Color(hex: "242424"))
    }
    
    private var navigationBar: some View {
        HStack {
            // Track switch button (왼쪽)
            Button(action: {
                viewModel.toggleTrack()
            }) {
                ZStack {
                    if #available(watchOS 26, *) {
                        Circle()
                            .frame(width: 30, height: 30)
                            .glassEffect(.clear, in: Circle())
                    } else {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                            )
                    }
                    
                    Image(systemName: viewModel.currentTrack.buttonText.lowercased() + ".circle")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            VStack {
                Spacer()
                
                // Track name
                Text(viewModel.currentTrack.displayName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(hex: "F14D35"))
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .frame(height: 40)
    }
    
    private var sessionList: some View {
        ScrollView {
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .tint(Color(hex: "F14D35"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                }
                .frame(height: 100)
            } else if viewModel.filteredSessions.isEmpty {
                VStack {
                    Spacer()
                    Text("세션이 없습니다")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                }
                .frame(height: 100)
            } else {
                VStack(spacing: 8) {
                    ForEach(Array(viewModel.filteredSessions.enumerated()), id: \.element.id) { index, session in
                        SessionCard(session: session, onTap: {
                            selectedSession = session
                        }, viewModel: viewModel, isLast: index == viewModel.filteredSessions.count - 1)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 8)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    TimetableView()
}
