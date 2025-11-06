//
//  LetSwift_iOS_WidgetLiveActivity.swift
//  LetSwift-iOS-Widget
//
//  Created by 김인환 on 10/20/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LetSwift_iOS_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PresentationAttributes.self) { context in
            HStack(alignment: .top, spacing: 8) {
                Image(.logo2025200)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(context.state.currentStatus == .upcoming ? Color(.upcoming) : Color(.themePrimary), lineWidth: 3)
                    )
                    .overlay(alignment: .bottomTrailing) {
                        Circle()
                            .fill(context.state.currentStatus == .upcoming ? Color(.upcoming) : Color(.themePrimary))
                            .frame(width: 18, height: 18)
                            .overlay(
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 13, height: 12)
                                    .foregroundColor(.white)
                            )
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 0) {
                        Text(context.state.title)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.white)
                        
                        Spacer()
                        
                        if let location = context.state.location {
                            Text(location)
                                .font(.system(size: 10))
                                .foregroundStyle(Color.white.opacity(0.6))
                        }
                    }
                    
                    Text(context.state.speakers.map(\.name).joined(separator: ", "))
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                    
                    switch context.state.currentStatus {
                    case .upcoming:
                        Text("세션이 곧 시작할 예정입니다.")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color.white.opacity(0.6))

                    case .ongoing:
                        if let startDate = parseDate(from: context.state.startTime),
                           let endDate = parseDate(from: context.state.endTime) {
                            ProgressView(
                                timerInterval: startDate...endDate,
                                countsDown: false,
                                label: { EmptyView() },
                                currentValueLabel: {
                                    Text(startDate, style: .time) + Text(" ~ ") + Text(endDate, style: .time)
                                }
                            )
                            .progressViewStyle(.linear)
                            .tint(Color(.themePrimary))
                            .padding(.top, 10)
                        } else {
                            Text("진행 중")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Color.white.opacity(0.6))
                        }

                    default:
                        EmptyView()
                    }
                }
            }
            .padding()
            .activitySystemActionForegroundColor(Color.white)
            .activityBackgroundTint(Color.black.opacity(0.7))
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded view
                DynamicIslandExpandedRegion(.leading) {
                    Image(.logo2025200)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .padding(.leading, 8)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    Image(systemName: context.state.currentStatus == .upcoming ? "clock.badge" : "clock.fill")
                        .font(.system(size: 14))
                        .foregroundColor(context.state.currentStatus == .upcoming ? Color(.upcoming) : Color(.themePrimary))
                        .padding(.trailing, 8)
                }

                DynamicIslandExpandedRegion(.bottom) {
                    VStack(spacing: 6) {
                        // Title
                        HStack {
                            Text(context.state.title)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Spacer(minLength: 0)
                        }

                        // Speakers and Location row
                        HStack(spacing: 8) {
                            // Speakers
                            HStack(spacing: 3) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white.opacity(0.6))

                                Text(context.state.speakers.map(\.name).joined(separator: ", "))
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white.opacity(0.8))
                                    .lineLimit(1)
                            }

                            Spacer(minLength: 0)

                            // Location
                            if let location = context.state.location {
                                HStack(spacing: 3) {
                                    Image(systemName: "location.fill")
                                        .font(.system(size: 10))
                                        .foregroundStyle(.white.opacity(0.6))

                                    Text(location)
                                        .font(.system(size: 9))
                                        .foregroundStyle(.white.opacity(0.8))
                                        .lineLimit(1)
                                }
                            }
                        }

                        // Status-specific content
                        switch context.state.currentStatus {
                        case .upcoming:
                            if let startDate = parseDate(from: context.state.startTime) {
                                HStack {
                                    HStack(spacing: 3) {
                                        Image(systemName: "clock")
                                            .font(.system(size: 8))
                                            .foregroundStyle(Color(.upcoming))

                                        (Text("시작: ") + Text(startDate, style: .time))
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundStyle(.white.opacity(0.9))
                                    }
                                    Spacer(minLength: 0)
                                }
                            }

                        case .ongoing:
                            if let startDate = parseDate(from: context.state.startTime),
                               let endDate = parseDate(from: context.state.endTime) {
                                ProgressView(
                                    timerInterval: startDate...endDate,
                                    countsDown: false,
                                    label: { EmptyView() },
                                    currentValueLabel: { EmptyView() }
                                )
                                .progressViewStyle(.linear)
                                .tint(Color(.themePrimary))
                            }

                        default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                    .padding(.bottom, 12)
                }

            } compactLeading: {
                // Compact leading - Logo
                Image(.logo2025200)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .clipShape(Circle())

            } compactTrailing: {
                // Compact trailing - Circular progress or icon
                if context.state.currentStatus == .ongoing,
                   let startDate = parseDate(from: context.state.startTime),
                   let endDate = parseDate(from: context.state.endTime) {
                    ProgressView(
                        timerInterval: startDate...endDate,
                        countsDown: false,
                        label: { EmptyView() },
                        currentValueLabel: { EmptyView() }
                    )
                    .progressViewStyle(.circular)
                    .tint(Color(.themePrimary))
                    .frame(width: 20, height: 20)
                } else {
                    Image(systemName: "clock.badge")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.upcoming))
                }

            } minimal: {
                // Minimal view - Circular progress or icon
                if context.state.currentStatus == .ongoing,
                   let startDate = parseDate(from: context.state.startTime),
                   let endDate = parseDate(from: context.state.endTime) {
                    ProgressView(
                        timerInterval: startDate...endDate,
                        countsDown: false,
                        label: { EmptyView() },
                        currentValueLabel: { EmptyView() }
                    )
                    .progressViewStyle(.circular)
                    .tint(Color(.themePrimary))
                    .frame(width: 16, height: 16)
                } else {
                    Image(systemName: "clock.badge")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.upcoming))
                }
            }
        }
    }

    private func parseDate(from dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

        // Try with timezone first
        if let date = formatter.date(from: dateString) {
            return date
        }

        // Try without timezone (add Z)
        if let date = formatter.date(from: dateString + "Z") {
            return date
        }

        // Fallback to DateFormatter
        let fallbackFormatter = DateFormatter()
        fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        fallbackFormatter.timeZone = TimeZone.current
        return fallbackFormatter.date(from: dateString)
    }
}

extension PresentationAttributes {
    fileprivate static var preview: PresentationAttributes {
        PresentationAttributes(track: "A")
    }
}

extension PresentationAttributes.ContentState {
    fileprivate static var ongoing: PresentationAttributes.ContentState {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

        return PresentationAttributes.ContentState(
            presentationId: 1,
            title: "SwiftUI 심화 기법",
            speakers: [
                Speaker(name: "홍길동", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Hong"),
                Speaker(name: "김철수", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Kim")
            ],
            location: "메인홀",
            startTime: formatter.string(from: now.addingTimeInterval(-600)), // 10분 전 시작
            endTime: formatter.string(from: now.addingTimeInterval(2400)), // 40분 남음 (총 50분)
            track: "A",
            currentStatus: .ongoing
        )
    }

    fileprivate static var upcoming: PresentationAttributes.ContentState {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

        return PresentationAttributes.ContentState(
            presentationId: 2,
            title: "Combine 프레임워크 완벽 가이드",
            speakers: [
                Speaker(name: "이영희", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Lee")
            ],
            location: "세미나실 B",
            startTime: formatter.string(from: now.addingTimeInterval(900)), // 15분 후 시작
            endTime: formatter.string(from: now.addingTimeInterval(3600)), // 1시간 후 종료
            track: "B",
            currentStatus: .upcoming
        )
    }

    fileprivate static var upcomingSoon: PresentationAttributes.ContentState {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

        return PresentationAttributes.ContentState(
            presentationId: 3,
            title: "iOS 성능 최적화",
            speakers: [
                Speaker(name: "박민수", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Park")
            ],
            location: "컨퍼런스홀",
            startTime: formatter.string(from: now.addingTimeInterval(180)), // 3분 후 시작
            endTime: formatter.string(from: now.addingTimeInterval(2700)), // 45분 후 종료
            track: "C",
            currentStatus: .upcoming
        )
    }

    fileprivate static var ongoingAlmostDone: PresentationAttributes.ContentState {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

        return PresentationAttributes.ContentState(
            presentationId: 4,
            title: "Swift Concurrency 마스터하기",
            speakers: [
                Speaker(name: "정수진", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Jung"),
                Speaker(name: "최영호", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Choi")
            ],
            location: "대강당",
            startTime: formatter.string(from: now.addingTimeInterval(-2700)), // 45분 전 시작
            endTime: formatter.string(from: now.addingTimeInterval(300)), // 5분 남음
            track: "D",
            currentStatus: .ongoing
        )
    }
}

// MARK: - Previews

// Lock Screen Preview
#Preview("Lock Screen", as: .content, using: PresentationAttributes.preview) {
   LetSwift_iOS_WidgetLiveActivity()
} contentStates: {
    PresentationAttributes.ContentState.ongoing
    PresentationAttributes.ContentState.upcoming
    PresentationAttributes.ContentState.upcomingSoon
    PresentationAttributes.ContentState.ongoingAlmostDone
}

// Dynamic Island - Compact Preview
#Preview("Dynamic Island - Compact", as: .dynamicIsland(.compact), using: PresentationAttributes.preview) {
    LetSwift_iOS_WidgetLiveActivity()
} contentStates: {
    PresentationAttributes.ContentState.ongoing
    PresentationAttributes.ContentState.upcoming
    PresentationAttributes.ContentState.upcomingSoon
}

// Dynamic Island - Minimal Preview
#Preview("Dynamic Island - Minimal", as: .dynamicIsland(.minimal), using: PresentationAttributes.preview) {
    LetSwift_iOS_WidgetLiveActivity()
} contentStates: {
    PresentationAttributes.ContentState.ongoing
    PresentationAttributes.ContentState.upcoming
}

// Dynamic Island - Expanded Preview
#Preview("Dynamic Island - Expanded", as: .dynamicIsland(.expanded), using: PresentationAttributes.preview) {
    LetSwift_iOS_WidgetLiveActivity()
} contentStates: {
    PresentationAttributes.ContentState.ongoing
    PresentationAttributes.ContentState.upcoming
    PresentationAttributes.ContentState.upcomingSoon
    PresentationAttributes.ContentState.ongoingAlmostDone
}
