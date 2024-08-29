//
//  SessionView.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import SwiftUI

struct SessionView: View {
    @State private var currentTab: Tab = .trackA
    @State private var sessions: [Session] = Session.sampleData
    @State private var savedSessionIds: Set<String> = Set(UserDefaults.standard.stringArray(forKey: "savedSessions") ?? [])

    enum Tab: String, Identifiable, CaseIterable {
        var id: String { self.rawValue }
        case trackA, trackB, savedSession

        var title: String {
            switch self {
            case .trackA: return "Track A"
            case .trackB: return "Track B"
            case .savedSession: return NSLocalizedString("timetable.tab.savedSession", comment: "Saved Session tab title")
            }
        }
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
    }

    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases) { tab in
                Button {
                    currentTab = tab
                } label: {
                    ZStack {
                        Color.darkBackground
                        Text(tab.title)
                            .font(currentTab == tab ? .medium(size: 15) : .regular(size: 15))
                            .foregroundStyle(currentTab == tab ? Color.primaryPink : Color.gray5)
                    }
                    .overlay(alignment: .bottom) {
                        if currentTab == tab {
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
                ForEach(filteredSessions) { session in
                    SessionRowView(session: session, isSaved: savedSessionIds.contains(session.id)) {
                        toggleSavedSession(session.id)
                    }
                    .overlay(alignment: .top) {
                        if session != filteredSessions.first {
                            Color.grayStoke
                                .frame(height: 1)
                        }
                    }
                }
            }
        }
    }

    private var filteredSessions: [Session] {
        switch currentTab {
        case .trackA:
            return sessions.filter { $0.track == "Track A" }
        case .trackB:
            return sessions.filter { $0.track == "Track B" }
        case .savedSession:
            return sessions.filter { savedSessionIds.contains($0.id) }
        }
    }

    private func toggleSavedSession(_ id: String) {
        if savedSessionIds.contains(id) {
            savedSessionIds.remove(id)
        } else {
            savedSessionIds.insert(id)
        }
        UserDefaults.standard.set(Array(savedSessionIds), forKey: "savedSessions")
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
    SessionView()
}
