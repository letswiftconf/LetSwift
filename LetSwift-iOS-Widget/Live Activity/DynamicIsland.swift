//
//  DynamicIsland.swift
//  LetSwift-iOS-WidgetExtension
//
//  Created by BumMo Koo on 11/21/25.
//

import Foundation
import WidgetKit
import SwiftUI
import ActivityKit

// Becuase volcano generates islands
final class Volcano {
    static func createDynamicIsland(with context: ActivityViewContext<PresentationAttributes>) -> DynamicIsland {
        DynamicIsland {
            // Expanded view
            DynamicIslandExpandedRegion(.leading) {
                expandedLeading(with: context)
            }
            DynamicIslandExpandedRegion(.trailing) {
                expandedTrailing(with: context)
            }
            DynamicIslandExpandedRegion(.bottom) {
                expandedBottom(with: context)
            }
        } compactLeading: {
            compactLeading(with: context)
        } compactTrailing: {
            compactTrailing(with: context)
        } minimal: {
            minimal(with: context)
        }
    }
    
    // MARK: Compact leading - Logo
    private static func compactLeading(with context: ActivityViewContext<PresentationAttributes>) -> some View {
        Image(.logo2025200)
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .clipShape(Circle())
    }
    
    // MARK: Compact trailing - Circular progress or icon
    private static func compactTrailing(with context: ActivityViewContext<PresentationAttributes>) -> some View {
        Group {
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
        }
    }
    
    // MARK: Minimal view - Circular progress or icon
    @ViewBuilder
    private static func minimal(with context: ActivityViewContext<PresentationAttributes>) -> some View {
        if context.state.currentStatus == .ongoing,
           let startDate = parseDate(from: context.state.startTime),
           let endDate = parseDate(from: context.state.endTime) {
            ZStack {
                ProgressView(
                    timerInterval: startDate...endDate,
                    countsDown: false,
                    label: { EmptyView() },
                    currentValueLabel: { EmptyView() }
                )
                .progressViewStyle(.circular)
                .tint(Color(.themePrimary))
                .frame(width: 16, height: 16)
                Image(.logo2025200)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .clipShape(Circle())
            }
        } else {
            Image(systemName: "clock.badge")
                .font(.system(size: 12))
                .foregroundColor(Color(.upcoming))
        }
    }
    
    // MARK: Expanded view
    @ViewBuilder
    private static func expandedLeading(with context: ActivityViewContext<PresentationAttributes>) -> some View {
        Image(.logo2025200)
            .resizable()
            .scaledToFit()
            .frame(width: 32, height: 32)
            .clipShape(Circle())
            .padding(.leading, 8)
    }
    
    private static func expandedTrailing(with context: ActivityViewContext<PresentationAttributes>) -> some View {
        Image(systemName: context.state.currentStatus == .upcoming ? "clock.badge" : "clock.fill")
            .font(.system(size: 14))
            .foregroundColor(context.state.currentStatus == .upcoming ? Color(.upcoming) : Color(.themePrimary))
            .padding(.trailing, 8)
    }
    
    private static func expandedBottom(with context: ActivityViewContext<PresentationAttributes>) -> some View {
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
}

// MARK: - Previews
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
