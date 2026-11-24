//
//  MoreView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI
import Accessibility
import PassKit
import BetterSafariView
import OSLog

private let logger = Logger(subsystem: "kr.codesquad.jk.letswift", category: "MoreView")

struct MoreView: View {
    @Environment(\.openURL) private var openURL
    @State private var featureFlagController = FeatureFlagController.shared

    @State private var presentURL: URL? = nil
    @State private var showSurveyUnavailableAlert = false
    @State private var showAddPassSheet = false
    @State private var commemorativePass: PKPass?
    @State private var isLoadingPass = false

    var body: some View {
        NavigationStack {
            List {
                letswiftSection
                passSection
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
            Button("alert.confirm", role: .cancel) { }
        }
        .sheet(isPresented: $showAddPassSheet) {
            if let commemorativePass {
                AddPassToWalletView(pass: commemorativePass)
            }
        }
        .overlay {
            if isLoadingPass {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .tint(.white)
                        .accessibilityLabel("settings.pass.loading")
                }
            }
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
            .accessibilityExternalLink()
            Button {
                present(url: URL.letswiftNewsletter)
            } label: {
                ListItem(title: "settings.linkNewsletter", style: .externalLink)
            }
            .buttonStyle(.plain)
            .accessibilityExternalLink()
            if featureFlagController.enableSurvey2025 {
                Button {
                    presentSurveyIfAvailable()
                } label: {
                    ListItem(title: "settings.conferenceReview", style: .externalLink)
                }
                .buttonStyle(.plain)
                .accessibilityExternalLink()
            }
        } header: {
            Text("settings.section.letswift")
        }
    }
    
    // MARK: - Pass section
    @ViewBuilder
    private var passSection: some View {
        if featureFlagController.enableCommemorativePass2025 {
            Section {
                Button {
                    presentAddToAppleWalletIfAvailable()
                } label: {
                    ListItem(title: "settings.addToAppleWallet", style: .none)
                }
                .buttonStyle(.plain)
            } header: {
                Text("settings.section.pass")
            }
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
            .accessibilityExternalLink()
            Button {
                present(url: URL.githubWebRepository)
            } label: {
                ListItem(title: "settings.linkWebRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
            .accessibilityExternalLink()
            Button {
                present(url: URL.githubNewsletterRepository)
            } label: {
                ListItem(title: "settings.linkNewsletterRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
            .accessibilityExternalLink()
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
            .accessibilityExternalLink()
            HStack {
                Text("settings.appVersion")
                Spacer()
                Text(Bundle.appVersion)
                    .foregroundStyle(.secondary)
            }
            // One swipe: "Version, 10.0 (Build 2)".
            .accessibilityElement(children: .combine)
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
        if featureFlagController.enableSurvey2025 {
            present(url: URL.letswiftReview)
        } else {
            showSurveyUnavailableAlert = true
        }
    }

    private func presentAddToAppleWalletIfAvailable() {
        guard featureFlagController.enableCommemorativePass2025 else {
            return
        }
        guard !isLoadingPass else {
            // The dimmed screen stops touches, but not VoiceOver, Switch Control or a keyboard.
            announce("settings.pass.loading")
            return
        }

        // Set before the task starts, so a second activation right behind the first is caught above.
        isLoadingPass = true
        Task {
            await downloadAndPresentPass()
        }
    }

    private func downloadAndPresentPass() async {
        announce("settings.pass.loading")

        do {
            logger.debug("Downloading commemorative pass...")
            let (data, _) = try await URLSession.shared.data(from: .commemorativePass2025)

            guard let pass = try? PKPass(data: data) else {
                logger.error("Invalid pass data")
                isLoadingPass = false
                announce("settings.pass.loadFailed", interrupting: true)
                return
            }

            logger.debug("Successfully downloaded pass")
            commemorativePass = pass
            isLoadingPass = false
            showAddPassSheet = true
        } catch {
            logger.error("Failed to download pass: \(error)")
            isLoadingPass = false
            announce("settings.pass.loadFailed", interrupting: true)
        }
    }

    /// Tells VoiceOver what the pass download is doing; the spinner and its disappearance are only visible.
    private func announce(_ message: LocalizedStringResource, interrupting: Bool = false) {
        var announcement = AttributedString(String(localized: message))
        if interrupting {
            // A failure must not get lost behind other speech.
            announcement.accessibilitySpeechAnnouncementPriority = .high
        }
        AccessibilityNotification.Announcement(announcement).post()
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
