//
//  MoreView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI
import BetterSafariView

struct MoreView: View {
    @Environment(\.openURL) private var openURL

    @State private var presentURL: URL? = nil
    @State private var showSurveyUnavailableAlert = false

    var body: some View {
        NavigationStack {
            List {
                letswiftSection
                openSourceSection
                appSection
#if DEBUG
                debugSection
#endif
            }
            .listStyle(.insetGrouped)
            .navigationTitle("settings.title")
        }
        .safariView(item: $presentURL) { item in
            SafariView(url: item, configuration: .init(entersReaderIfAvailable: false, barCollapsingEnabled: true))
                .preferredControlAccentColor(.themePrimary)
                .dismissButtonStyle(.close)
        }
        .alert("settings.survey.unavailable", isPresented: $showSurveyUnavailableAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // MARK: - Web section
    @ViewBuilder
    private var letswiftSection: some View {
        Section {
            Button {
                present(url: URL.letswiftHome)
            } label: {
                ListItem(title: "settings.linkHome", style: .externalLink)
            }
            .buttonStyle(.plain)
            Button {
                present(url: URL.letswiftNewsletter)
            } label: {
                ListItem(title: "settings.linkNewsletter", style: .externalLink)
            }
            .buttonStyle(.plain)
            if FeatureFlagController.shared.enableSurvey2025 {
                Button {
                    presentSurveyIfAvailable()
                } label: {
                    ListItem(title: "settings.conferenceReview", style: .externalLink)
                }
                .buttonStyle(.plain)
            }
        } header: {
            Text("settings.section.letswift")
        }
    }
    
    // MARK: - Debug section
    @ViewBuilder
    private var debugSection: some View {
        Section {
            NavigationLink("settings.appIcon") {
                AppIconView()
            }
        } header: {
            Text("settings.section.debug")
        }
    }
    
    // MARK: - Open source section
    @ViewBuilder
    private var openSourceSection: some View {
        Section {
            Button {
                present(url: URL.githubAppRepository)
            } label: {
                ListItem(title: "settings.linkAppRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
            Button {
                present(url: URL.githubWebRepository)
            } label: {
                ListItem(title: "settings.linkWebRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
            Button {
                present(url: URL.githubNewsletterRepository)
            } label: {
                ListItem(title: "settings.linkNewsletterRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
        } header: {
            Text("settings.section.openSource")
        }
    }
    
    // MARK: - App Section
    @ViewBuilder
    private var appSection: some View {
        Section {
            Button {
                openURL(URL.appStoreReview)
            } label: {
                ListItem(title: "settings.requestReview", style: .externalLink)
            }
            .buttonStyle(.plain)
            HStack {
                Text("settings.appVersion")
                Spacer()
                Text(Bundle.appVersion)
                    .foregroundStyle(.secondary)
            }
        } header: {
            Text("settings.section.app")
        }
    }
    
    // MARK: - Action
    private func present(url: URL?) {
        guard let url = url else {
            return
        }
        presentURL = url
//        openURL(url)
    }

    private func presentSurveyIfAvailable() {
        if FeatureFlagController.shared.enableSurvey2025 {
            present(url: URL.letswiftReview)
        } else {
            showSurveyUnavailableAlert = true
        }
    }
}

#Preview("More(ko)") {
    TabView {
        MoreView()
            .environment(\.locale, Locale(identifier: "ko"))
    }
}

#Preview("More(en)") {
    TabView {
        MoreView()
            .environment(\.locale, Locale(identifier: "en"))
    }
}
