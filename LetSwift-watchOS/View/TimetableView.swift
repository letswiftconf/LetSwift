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
            .background(Color(hex: "17171B"))
            .padding(.top, 20)
            .edgesIgnoringSafeArea(.all)
            
            // Popup overlay
            if let session = selectedSession {
                SessionDetailView(session: session, dismiss: {
                    selectedSession = nil
                })
                .zIndex(1)
                .padding(.top, 20)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var navigationBar: some View {
        HStack {
            // Track switch button (왼쪽)
            Button(action: {
                viewModel.toggleTrack()
            }) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "3F3F3F"))
                        .frame(width: 30, height: 30)
                    Text(viewModel.currentTrack.buttonText)
                        .font(.system(size: 14, weight: .semibold))
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
                    }, isLast: index == viewModel.filteredSessions.count - 1)
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    TimetableView()
}
