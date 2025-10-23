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
            // Lock screen/banner UI goes here
            VStack(alignment: .leading, spacing: 8) {
                Text(context.state.title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(context.state.speakers.map { $0.name }.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                HStack {
                    Text("Track \(context.state.track)")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(4)

                    Spacer()

                    Text(context.state.currentStatus)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }

                if let timeRemaining = context.state.timeRemaining, timeRemaining > 0 {
                    Text("\(timeRemaining)분 남음")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding()
            .activityBackgroundTint(Color.blue)
            .activitySystemActionForegroundColor(Color.white)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading) {
                        Text(context.state.title)
                            .font(.caption)
                        Text(context.state.speakers.map { $0.name }.joined(separator: ", "))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let timeRemaining = context.state.timeRemaining, timeRemaining > 0 {
                        VStack {
                            Text("\(timeRemaining)")
                                .font(.title2)
                            Text("분 남음")
                                .font(.caption2)
                        }
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Text("Track \(context.state.track)")
                            .font(.caption)
                        Spacer()
                        Text(context.state.currentStatus)
                            .font(.caption)
                    }
                }
            } compactLeading: {
                Text("🎤")
            } compactTrailing: {
                if let timeRemaining = context.state.timeRemaining, timeRemaining > 0 {
                    Text("\(timeRemaining)분")
                        .font(.caption2)
                }
            } minimal: {
                Text("🎤")
            }
        }
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
            currentStatus: "진행 중",
            timeRemaining: 25
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
            currentStatus: "시작 예정",
            timeRemaining: 30
        )
    }
}

#Preview("Notification", as: .content, using: PresentationAttributes.preview) {
   LetSwift_iOS_WidgetLiveActivity()
} contentStates: {
    PresentationAttributes.ContentState.ongoing
    PresentationAttributes.ContentState.upcoming
}
