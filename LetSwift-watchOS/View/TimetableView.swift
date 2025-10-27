//
//  TimetableView.swift
//  LetSwift-watchOS Watch App
//
//  Created by AI on 11/25/24.
//

import SwiftUI
import WatchKit

struct TimetableView: View {
    @State private var viewModel = WatchSessionViewModel()
    @State private var selectedSession: SessionItem?
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation bar
            navigationBar
            
            // Session list
            sessionList
        }
        .sheet(item: $selectedSession) { session in
            SessionDetailView(session: session)
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
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 28, height: 28)
                    Text(viewModel.currentTrack.buttonText)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            // Current track indicator (오른쪽)
            Text("\(viewModel.currentTrack.displayName)트랙")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.red)
            
            Spacer()
            
            Spacer()
                .frame(width: 28) // Balance the layout
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(height: 40)
    }
    
    private var sessionList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Array(viewModel.filteredSessions.enumerated()), id: \.element.id) { index, session in
                    SessionCard(session: session, onTap: {
                        selectedSession = session
                    }, isLast: index == viewModel.filteredSessions.count - 1)
                }
            }
            .padding(.top, 8)
        }
    }
}

struct SessionCard: View {
    let session: SessionItem
    let onTap: () -> Void
    @State private var isFavorite = false
    let isLast: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(session.timeRange)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text(session.name)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(session.durationString)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
                .padding(.vertical, 6)
                
                Button(action: {
                    HapticFeedback.click()
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isFavorite ? .red : .gray)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 8)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onTap()
            }
            
            if !isLast {
                Divider()
                    .background(Color.gray.opacity(0.2))
                    .padding(.leading, 8)
            }
        }
    }
}

struct SessionDetailView: View {
    let session: SessionItem
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(session.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                
                if !session.speakers.isEmpty {
                    Text(session.speakers.first ?? "")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                Text(session.timeRange)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                
                Text(session.durationString)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                
                Button(action: {
                    HapticFeedback.click()
                    dismiss()
                }) {
                    Text("닫기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
            .padding(12)
        }
    }
}

class HapticFeedback {
    static func play(_ type: WKHapticType) {
        WKInterfaceDevice.current().play(type)
    }
    
    static func notification() {
        WKInterfaceDevice.current().play(.notification)
    }
    
    static func click() {
        WKInterfaceDevice.current().play(.click)
    }
}

#Preview {
    TimetableView()
}

