//
//  LocationAndDateView.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/28.
//

import SwiftUI

struct LocationAndDateView: View {
  var onTapMapButton: () -> Void
  var onTapCalendarButton: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        locationTitle
        mapButton
      }

      Divider()
        .frame(height: 1)
        .overlay(.primaryLabel)
        .padding(.leading, 40)

      HStack(spacing: 0) {
        dateTitle
        calendarButton
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.groupBackground)
    .clipShape(RoundedRectangle(cornerRadius: 32, style: .circular))
  }
}

// MARK: - Subviews
extension LocationAndDateView {
  // MARK: Location
  private var locationTitle: some View {
    HStack(spacing: 0) {
      iconView(systemName: "location.fill")
        .padding(.trailing, 16)

      VStack(alignment: .leading, spacing: 0) {
        Text("home.location")
          .foregroundStyle(.title2)
          .font(.system(size: 17, weight: .regular))

        Text("서울 광진구 능동로 209")
          .font(.system(size: 15, weight: .regular))
          .foregroundStyle(.primaryLabel)
      }
      .padding(.vertical, 9)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: Date
  private var dateTitle: some View {
    HStack(spacing: 0) {
      iconView(systemName: "calendar")
        .padding(.trailing, 16)

      VStack(alignment: .leading, spacing: 0) {
        Text("home.date")
          .foregroundStyle(.title2)
          .font(.system(size: 17, weight: .regular))

        Text("2025.11.24. 10:00 ~")
          .font(.system(size: 15, weight: .regular))
          .foregroundStyle(.primaryLabel)
          .lineSpacing(3)
      }
      .padding(.vertical, 9)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: Buttons
  private var mapButton: some View {
    actionButton(
      title: "지도에서 보기",
      action: onTapMapButton
    )
  }

  private var calendarButton: some View {
    actionButton(
      title: "캘린더 추가",
      action: onTapCalendarButton
    )
  }

  private func iconView(systemName: String) -> some View {
    Text(Image(systemName: systemName))
      .font(.system(size: 14.5, weight: .semibold))
      .foregroundStyle(.themePrimary)
      .padding(6)
      .background {
          Circle().foregroundStyle(.themeSecondary)
      }
  }

  private func actionButton(title: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
      HStack(spacing: 16) {
        Text(title)
          .foregroundStyle(.themePrimary)
          .font(.system(size: 17, weight: .regular))
          .frame(height: 38)

        Text(Image(systemName: "chevron.right"))
          .font(.system(size: 17, weight: .semibold))
          .foregroundStyle(.background4)
      }
      .padding(.vertical, 22.5)
    }
  }
}

#Preview {
  LocationAndDateView(onTapMapButton: {}, onTapCalendarButton: {})
}
