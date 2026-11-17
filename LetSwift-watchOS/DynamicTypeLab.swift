//
//  DynamicTypeLab.swift
//  LetSwift-watchOS Watch App
//
//  TEMP (Dynamic Type lab): screenshot harness for DynamicTypeLab/run.sh.
//  Removed before merging.
//

#if DEBUG
import SwiftUI

/// Picks the screen to show from the environment, so `simctl launch` can open each screen directly.
/// - `DT_LAB_SCREEN`: event | timetable | session
/// - `DT_LAB_TEXT_SIZE`: 0...11 (xSmall ... accessibility5), overrides the system text size
/// - `DT_LAB_SCROLL`: "bottom" starts scroll views at their end
@MainActor
enum DynamicTypeLab {
    private static let environment = ProcessInfo.processInfo.environment

    static var screen: String? { environment["DT_LAB_SCREEN"] }
    static var isActive: Bool { screen != nil }

    static var textSize: DynamicTypeSize? {
        guard let value = environment["DT_LAB_TEXT_SIZE"], let index = Int(value),
              DynamicTypeSize.allCases.indices.contains(index) else { return nil }
        return DynamicTypeSize.allCases[index]
    }

    @ViewBuilder
    static var rootView: some View {
        Group {
            switch screen {
            case "timetable":
                NavigationStack { TimetableView(viewModel: sampleViewModel) }
            case "session":
                NavigationStack {
                    SessionDetailView(session: sampleSessions[1]) {}
                }
            default:
                ContentView()
            }
        }
        .modifier(TextSizeOverride(size: textSize))
        .defaultScrollAnchor(environment["DT_LAB_SCROLL"] == "bottom" ? .bottom : .top, for: .initialOffset)
    }

    /// Seeds the offline cache, so the event card shows without waiting for the network.
    static func prepare() {
        guard isActive else { return }
        let key = "cachedEvent-\(LetSwiftEvent.year)"
        if UserDefaults.standard.data(forKey: key) == nil,
           let event = CalendarEvent(ics: sampleEvent),
           let data = try? JSONEncoder().encode(event) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private struct TextSizeOverride: ViewModifier {
        let size: DynamicTypeSize?

        func body(content: Content) -> some View {
            if let size {
                content.dynamicTypeSize(size)
            } else {
                content
            }
        }
    }

    private static let sampleEvent = """
    BEGIN:VCALENDAR
    BEGIN:VEVENT
    SUMMARY:Let'Swift 2026 — 개발 환경의 변화 워크숍
    DTSTART;TZID=Asia/Seoul:20261208T190000
    DTEND;TZID=Asia/Seoul:20261208T213000
    LOCATION:서울 강남구 강남대로62길 23 역삼빌딩 4층 코드스쿼드
    END:VEVENT
    END:VCALENDAR
    """

    private static let sampleViewModel: WatchSessionViewModel = {
        let viewModel = WatchSessionViewModel()
        viewModel.sessions = sampleSessions
        return viewModel
    }()

    private static let sampleSessions: [SessionItem] = {
        let titles = [
            "오프닝",
            "늦었다고 생각할 때 진짜 늦었으니 UITest로 시나리오 테스트하기",
            "Swift 6 동시성",
            "Tuist, 도입은 했는데 그래서 Modular Architecture은 어떻게 만들어가면 되나요?",
        ]
        let start = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: .now) ?? .now
        return titles.enumerated().map { index, title in
            let begin = start.addingTimeInterval(Double(index) * 2700)
            return SessionItem(
                id: "lab-\(index)",
                name: title,
                type: .presentation,
                track: "A",
                startTime: begin,
                endTime: begin.addingTimeInterval(2400),
                duration: 2400,
                speakers: ["이재웅(커리)"]
            )
        }
    }()
}
#endif
