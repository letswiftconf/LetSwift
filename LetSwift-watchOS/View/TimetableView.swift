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
        ZStack {
            VStack(spacing: 0) {
                // Navigation bar
                navigationBar
                
                // Session list
                sessionList
            }
            .padding(.top, 20)
            .edgesIgnoringSafeArea(.all)
            
            // Popup overlay
            if let session = selectedSession {
                SessionDetailView(session: session, dismiss: {
                    selectedSession = nil
                })
                .zIndex(1)
                .edgesIgnoringSafeArea(.all)
            }
        }
        .background(Color(hex: "242424"))
    }
    
    private var navigationBar: some View {
        HStack {
            // Track switch button (왼쪽)
            Button(action: {
                viewModel.toggleTrack()
            }) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                        )
                    
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
                Text("\(viewModel.currentTrack.displayName)트랙")
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

#Preview {
    TimetableView()
}
