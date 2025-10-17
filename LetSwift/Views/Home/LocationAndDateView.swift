//
//  LocationAndDateView.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/28.
//

import SwiftUI

/// 장소&일시
struct LocationAndDateView: View {
    
    var onTapMapButton: () -> Void
    var onTapCalendarButton: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            locationTitle
            dateTitle
            HStack(spacing: 14) {
                mapBtn
                calendarBtn
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
    
    var locationTitle: some View {
        HStack(spacing: 0) {
            Image(systemName: "mappin.and.ellipse")
                .foregroundStyle(.secondary)
                .padding(.trailing, 8)
            Text("home.location")
                .foregroundStyle(.secondary)
                .font(.system(size: 14))
                .padding(.trailing, 18)
            Text("세종대학교 광개토회관")
                .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 6)
    }
    
    var dateTitle: some View {
        HStack(spacing: 0) {
            Image(systemName: "calendar")
                .foregroundStyle(.secondary)
                .padding(.trailing, 8)
            Text("home.date")
                .foregroundStyle(.secondary)
                .font(.system(size: 14))
                .padding(.trailing, 18)
            Text("2024년 11월 25일\n11:00 ~ 18:00")
                .font(.system(size: 14))
                .lineSpacing(3)
                .offset(y: 9)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 24)
    }
    
    var mapBtn: some View {
        Button(action: onTapMapButton) {
            Text("지도")
                .foregroundStyle(.primary)
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity)
                .frame(height: 38)
        }
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
    }
    
    var calendarBtn: some View {
        Button(action: onTapCalendarButton) {
            Text("캘린더 등록")
                .foregroundStyle(.primary)
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity)
                .frame(height: 38)
        }
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
    }
}

#Preview {
    LocationAndDateView(onTapMapButton: {}, onTapCalendarButton: {})
}
