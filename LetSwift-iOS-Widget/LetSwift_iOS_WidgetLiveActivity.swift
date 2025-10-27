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
                                    Text(startDate, style: .time) + Text(" ~ ") + Text(endDate, style: .time)ㅑ
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
                DynamicIslandExpandedRegion(.leading) {
                    EmptyView()
                }
                DynamicIslandExpandedRegion(.trailing) {
                    EmptyView()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    EmptyView()
                }
            } compactLeading: {
                EmptyView()
            } compactTrailing: {
                EmptyView()
            } minimal: {
                EmptyView()
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
        PresentationAttributes.ContentState(
            presentationId: 1,
            title: "SwiftUI 심화",
            speakers: [
                Speaker(name: "홍길동", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Hong"),
                Speaker(name: "김철수", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Kim")
            ],
            startTime: "2025-10-24T10:00:00",
            endTime: "2025-10-24T11:00:00",
            track: "A",
            currentStatus: .ongoing
        )
    }

    fileprivate static var upcoming: PresentationAttributes.ContentState {
        PresentationAttributes.ContentState(
            presentationId: 2,
            title: "Combine 프레임워크",
            speakers: [
                Speaker(name: "이영희", profileImage: "https://api.dicebear.com/7.x/avataaars/svg?seed=Lee")
            ],
            startTime: "2025-10-24T11:00:00",
            endTime: "2025-10-24T12:00:00",
            track: "B",
            currentStatus: .upcoming
        )
    }
}

#Preview("Notification", as: .content, using: PresentationAttributes.preview) {
   LetSwift_iOS_WidgetLiveActivity()
} contentStates: {
    PresentationAttributes.ContentState.ongoing
    PresentationAttributes.ContentState.upcoming
}
