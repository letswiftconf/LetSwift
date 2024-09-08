//
//  SessionView.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import SwiftUI

struct SessionView: View {
    
    @Bindable private var viewModel: SessionViewModel
    
    init(viewModel: SessionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                tabView
                sessionList
            }
            .background(Color.darkBackground)
            .navigationTitle("Sessions")
        }
        .tabItem {
            Label("timetable.title", image: "ic_timetable")
        }
        .task {
            defer { viewModel.update(isLoading: false) }
            viewModel.update(isLoading: true)
            guard let sessions = try? await viewModel.fetchSessions() else { return }
            viewModel.update(sessions: sessions)
        }
    }

    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(SessionTab.allCases) { tab in
                Button {
                    viewModel.update(currentTab: tab)
                } label: {
                    ZStack {
                        Color.darkBackground
                        Text(tab.title)
                            .font(viewModel.currentTab == tab ? .medium(size: 15) : .regular(size: 15))
                            .foregroundStyle(viewModel.currentTab == tab ? Color.primaryPink : Color.gray5)
                    }
                    .overlay(alignment: .bottom) {
                        if viewModel.currentTab == tab {
                            Color.primaryPink.frame(height: 3)
                        } else {
                            Color.gray5.frame(height: 1)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
    }

    private var sessionList: some View {
        ScrollView {
            VStack(spacing: 1) {
                ForEach(Array(viewModel.filteredSessions.enumerated()), id: \.offset) { offset, session in
                    SessionRowView(session: session, isSaved: viewModel.savedSessionIds.contains(session.id)) {
                        viewModel.toggleSavedSession(session.id)
                    }
                    .overlay(alignment: .top) {
                        if offset != .zero {
                            Color.grayStoke
                                .frame(height: 1)
                        }
                    }
                }
            }
        }
        .overlay {
            ProgressView()
                 .progressViewStyle(CircularProgressViewStyle())
                 .opacity(viewModel.isLoading ? 1.0 : 0.0)
        }
    }
}

struct SessionRowView: View {
    let session: Session
    let isSaved: Bool
    let onToggleSave: () -> Void

    var body: some View {
        HStack {
            VStack(spacing: 3) {
                Color.gray5
                    .frame(width: 1)
                
                Circle()
                    .stroke(Color.gray5)
                    .frame(width: 10, height: 10)
                
                Color.gray5
                    .frame(width: 1)
            }
            .padding(.leading, 29)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(LocalizedStringKey(session.name))
                    .font(.medium(size: 15))
                HStack {
                    if let speaker = session.speaker {
                        AsyncImage(url: URL(string: speaker.imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        
                        Text(LocalizedStringKey(speaker.name))
                            .font(.regular(size: 12))
                            .foregroundColor(.gray8)
                        
                        Text("·")
                            .font(.regular(size: 12))
                            .foregroundColor(.gray8)
                    }
                    
                    Text(formatTimeRange(start: session.startTime, end: session.endTime))
                        .font(.regular(size: 12))
                        .foregroundColor(.gray8)
                }
            }
            
            Spacer()
            
            Button(action: onToggleSave) {
                Image(isSaved ? "ic_bookmark_fill" : "ic_bookmark")
                    .frame(width: 40, height: 40)
            }
            .padding(.trailing, 8)
        }
        .frame(height: 120)
    }

    private func formatTimeRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return "\(formatter.string(from: start)) ~ \(formatter.string(from: end))"
    }
}

#Preview {
    SessionView(viewModel: SessionViewModel())
}
