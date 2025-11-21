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
        let configuration = ActivityConfiguration(for: PresentationAttributes.self) { context in
            if #available(iOS 18.0, *) {
                LiveActivityContentView(context: context)
            } else {
                LiveActivityBaseView(
                    context: context,
                    iconSize: 52,
                    badgeSize: 18,
                    clockIconSize: 13
                )
            }
        } dynamicIsland: { context in
            Volcano.createDynamicIsland(with: context)
        }
        if #available(iOS 18.0, *) {
            return configuration
                .supplementalActivityFamilies([.small, .medium])
        } else {
            return configuration
        }
    }
}

// MARK: - Live Activity Content View
@available(iOS 18.0, *)
private struct LiveActivityContentView: View {
    let context: ActivityViewContext<PresentationAttributes>
    @Environment(\.activityFamily) private var activityFamily

    // 스마트 스택에서는 작은 아이콘, 일반 라이브 액티비티에서는 기본 크기
    private var isSmartStack: Bool {
//        activityFamily == .small || activityFamily == .medium
        activityFamily == .small
    }

    private var iconSize: CGFloat {
        isSmartStack ? 28 : 52
    }

    private var badgeSize: CGFloat {
        isSmartStack ? 12 : 18
    }

    private var clockIconSize: CGFloat {
        isSmartStack ? 8 : 13
    }

    var body: some View {
        LiveActivityBaseView(
            context: context,
            iconSize: iconSize,
            badgeSize: badgeSize,
            clockIconSize: clockIconSize,
            isCompact: isSmartStack
        )
    }
}

// MARK: - Live Activity Base View
private struct LiveActivityBaseView: View {
    let context: ActivityViewContext<PresentationAttributes>
    let iconSize: CGFloat
    let badgeSize: CGFloat
    let clockIconSize: CGFloat
    var isCompact: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: isCompact ? 6 : 8) {
            LiveActivityIconView(
                status: context.state.currentStatus,
                iconSize: iconSize,
                badgeSize: badgeSize,
                clockIconSize: clockIconSize
            )

            LiveActivityTextContentView(context: context, isCompact: isCompact)
        }
        .padding(isCompact ? 8 : 12)
        .activitySystemActionForegroundColor(Color.white)
        .activityBackgroundTint(Color.black.opacity(0.7))
    }
}

// MARK: - Live Activity Icon View
private struct LiveActivityIconView: View {
    let status: PresentationAttributes.ContentState.Status
    let iconSize: CGFloat
    let badgeSize: CGFloat
    let clockIconSize: CGFloat

    var body: some View {
        Image(.logo2025200)
            .resizable()
            .scaledToFit()
            .frame(width: iconSize, height: iconSize)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(status == .upcoming ? Color(.upcoming) : Color(.themePrimary), lineWidth: 3)
            )
            .overlay(alignment: .bottomTrailing) {
                Circle()
                    .fill(status == .upcoming ? Color(.upcoming) : Color(.themePrimary))
                    .frame(width: badgeSize, height: badgeSize)
                    .overlay(
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: clockIconSize, height: clockIconSize - 1)
                            .foregroundColor(.white)
                    )
            }
    }
}

// MARK: - Live Activity Text Content View
private struct LiveActivityTextContentView: View {
    let context: ActivityViewContext<PresentationAttributes>
    var isCompact: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: isCompact ? 2 : 4) {
            HStack(alignment: .top, spacing: 0) {
                Text(context.state.title)
                    .font(.system(size: isCompact ? 10 : 15, weight: .bold))
                    .foregroundStyle(Color.white)
                    .lineLimit(2)

                Spacer()

                if let location = context.state.location {
                    Text(location)
                        .font(.system(size: isCompact ? 8 : 10))
                        .foregroundStyle(Color.white.opacity(0.6))
                        .lineLimit(1)
                }
            }

            Text(context.state.speakers.map(\.name).joined(separator: ", "))
                .font(.system(size: isCompact ? 8 : 14))
                .foregroundStyle(Color.white)
                .lineLimit(1)

            LiveActivityStatusView(context: context, isCompact: isCompact)
        }
    }
}

// MARK: - Live Activity Status View
private struct LiveActivityStatusView: View {
    let context: ActivityViewContext<PresentationAttributes>
    var isCompact: Bool = false

    var body: some View {
        switch context.state.currentStatus {
        case .upcoming:
            Text(isCompact ? "곧 시작" : "세션이 곧 시작할 예정입니다.")
                .font(.system(size: isCompact ? 8 : 10, weight: .bold))
                .foregroundStyle(Color.white.opacity(0.6))
                .lineLimit(1)

        case .ongoing:
            if let startDate = parseDate(from: context.state.startTime),
               let endDate = parseDate(from: context.state.endTime) {
                ProgressView(
                    timerInterval: startDate...endDate,
                    countsDown: false,
                    label: { EmptyView() },
                    currentValueLabel: {
                        if isCompact {
                            EmptyView()
                        } else {
                            Text(startDate, style: .time) + Text(" ~ ") + Text(endDate, style: .time)
                        }
                    }
                )
                .progressViewStyle(.linear)
                .tint(Color(.themePrimary))
                .padding(.top, isCompact ? 4 : 10)
            } else {
                Text("진행 중")
                    .font(.system(size: isCompact ? 8 : 10, weight: .bold))
                    .foregroundStyle(Color.white.opacity(0.6))
                    .lineLimit(1)
            }

        default:
            EmptyView()
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
    static var preview: PresentationAttributes {
        PresentationAttributes(track: "A")
    }
}

extension PresentationAttributes.ContentState {
    static var ongoing: PresentationAttributes.ContentState {
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

    static var upcoming: PresentationAttributes.ContentState {
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

    static var upcomingSoon: PresentationAttributes.ContentState {
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

    static var ongoingAlmostDone: PresentationAttributes.ContentState {
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

func parseDate(from dateString: String) -> Date? {
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
