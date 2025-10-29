//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import BetterSafariView
import SwiftUI

struct HomeView: View {
  @State private var presentURL: URL? = nil
  @StateObject private var viewModel = HomeViewModel()

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        header
        locationAndDateSection
        divider
        buttonStack
      }
    }
    .background(Color("System/background"))
    .customAlert($viewModel.alert)
    .safariView(item: $presentURL) { item in
      SafariView(
        url: item,
        configuration: .init(
          entersReaderIfAvailable: false,
          barCollapsingEnabled: true
        )
      )
      .preferredControlAccentColor(.themePrimary)
      .dismissButtonStyle(.close)
    }
  }
}

// MARK: - Subviews
extension HomeView {
  private var header: some View {
    HStack(spacing: 20) {
      Image("logo_2025_200")
        .resizable()
        .frame(width: 104, height: 103)

      VStack(alignment: .leading, spacing: 2) {
        Text("appIcon.2025")
          .font(.system(size: 24, weight: .bold))
        Text("Ember to Stars!")
          .font(.system(size: 12))
      }
      .foregroundStyle(.title1)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.horizontal, 35)
    .padding(.vertical, 32)
  }

  private var locationAndDateSection: some View {
    LocationAndDateView {
      Task {
        await open(viewModel.mapUrlScheme)
      }
    } onTapCalendarButton: {
      viewModel.addEvent()
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 23)
  }

  private var divider: some View {
    Divider()
      .frame(height: 1)
      .overlay(Color("System/separator1"))
      .padding(.leading, 45)
      .padding(.bottom, 17)
  }

  private var buttonStack: some View {
    HStack(spacing: 17) {
      ForEach(viewModel.outlinks) { link in
        LinkButton(title: link.title, icon: link.iconName) {
          present(url: link.url)
        }
      }
    }
    .padding(.horizontal, 16)
  }
}

// MARK: - Actions
extension HomeView {
  private func present(url: URL?) {
    guard let url else {
      return
    }
    presentURL = url
  }

  private func open(_ urlString: String) async -> Bool {
    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
      return await UIApplication.shared.open(url)
    }

    return false
  }
}

#Preview {
  TabView {
    HomeView()
  }
  .environment(\.locale, .init(identifier: "ko"))
}
