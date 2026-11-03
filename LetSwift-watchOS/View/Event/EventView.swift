//
//  EventView.swift
//  LetSwift-watchOS Watch App
//

import SwiftUI

/// Main screen: the current Let'Swift event, plus the timetable when the event has one.
struct EventView: View {
    @State private var eventViewModel = EventViewModel()
    @State private var sessionViewModel = WatchSessionViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if let event = eventViewModel.event {
                        EventCard(event: event)
                    } else if eventViewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        noEventView
                    }

                    if !sessionViewModel.sessions.isEmpty {
                        NavigationLink {
                            TimetableView(viewModel: sessionViewModel)
                        } label: {
                            Label("event.timetable", systemImage: "list.bullet.rectangle")
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .navigationTitle("Let'Swift")
        }
        .task {
            async let event: Void = eventViewModel.load()
            async let sessions: Void = sessionViewModel.loadSessionsOnce()
            _ = await (event, sessions)
        }
    }

    private var noEventView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("event.none.title")
                .font(.headline)
            Text("event.none.message")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

private struct EventCard: View {
    let event: CalendarEvent

    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            statusBadge

            Text(event.title)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment: .leading, spacing: 4) {
                Label {
                    Text(event.startDate, format: .dateTime.month().day().weekday())
                } icon: {
                    Image(systemName: "calendar")
                }
                if !event.isAllDay {
                    Label {
                        Text(event.startDate..<event.endDate, format: .interval.hour().minute())
                    } icon: {
                        Image(systemName: "clock")
                    }
                }
                if let location = event.location {
                    Label(location, systemImage: "mappin.and.ellipse")
                        .lineLimit(3)
                }
            }
            .font(.footnote)
            .foregroundStyle(.secondary)

            if let location = event.location, let mapsURL = Self.mapsURL(for: location) {
                Button("event.openMaps", systemImage: "map") {
                    openURL(mapsURL)
                }
            }
        }
    }

    @ViewBuilder
    private var statusBadge: some View {
        Group {
            switch event.status() {
            case .upcoming(let days):
                Text("event.status.dday \(days)")
            case .today:
                Text("event.status.today")
            case .live:
                Text("event.status.live")
            case .ended:
                Text("event.status.ended")
            }
        }
        .font(.caption.weight(.semibold))
        .foregroundStyle(Color(hex: "F14D35"))
    }

    private static func mapsURL(for location: String) -> URL? {
        var components = URLComponents(string: "https://maps.apple.com/")
        components?.queryItems = [URLQueryItem(name: "q", value: location)]
        return components?.url
    }
}

#Preview {
    EventView()
}
