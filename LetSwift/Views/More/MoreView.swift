//
//  MoreView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI
import PassKit
import BetterSafariView

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
            Button("OK", role: .cancel) { }
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
            Button {
                present(url: URL.letswiftNewsletter)
            } label: {
                ListItem(title: "settings.linkNewsletter", style: .externalLink)
            }
            .buttonStyle(.plain)
            if featureFlagController.enableSurvey2025 {
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

        Task {
            await downloadAndPresentPass()
        }
    }

    private func downloadAndPresentPass() async {
        isLoadingPass = true

        do {
            print("[MoreView] Downloading commemorative pass...")
            let (data, _) = try await URLSession.shared.data(from: .commemorativePass2025)

            guard let pass = try? PKPass(data: data) else {
                print("[MoreView] ❌ Invalid pass data")
                isLoadingPass = false
                return
            }

            print("[MoreView] Successfully downloaded pass")
            commemorativePass = pass
            isLoadingPass = false
            showAddPassSheet = true
        } catch {
            print("[MoreView] ❌ Failed to download pass: \(error)")
            isLoadingPass = false
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
