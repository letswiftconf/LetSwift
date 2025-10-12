//
//  MoreView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI

struct MoreView: View {
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationStack {
            List {
                letswiftSection
                openSourceSection
                appSection
            }
            .listStyle(.insetGrouped)
            .navigationTitle("settings.title")
        }
    }
    
    // MARK: - Web section
    @ViewBuilder
    private var letswiftSection: some View {
        Section {
            Button {
                openURL(URL.letswiftHome)
            } label: {
                ListItem(title: "settings.linkHome", style: .externalLink)
            }
            .buttonStyle(.plain)
            Button {
                openURL(URL.letswiftNewsletter)
            } label: {
                ListItem(title: "settings.linkNewsletter", style: .externalLink)
            }
            .buttonStyle(.plain)
        } header: {
            Text("settings.section.letswift")
        }
    }
    
    // MARK: - Open source section
    @ViewBuilder
    private var openSourceSection: some View {
        Section {
            Button {
                openURL(URL.githubAppRepository)
            } label: {
                ListItem(title: "settings.linkAppRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
            Button {
                openURL(URL.githubWebRepository)
            } label: {
                ListItem(title: "settings.linkWebRepository", style: .externalLink)
            }
            .buttonStyle(.plain)
            Button {
                openURL(URL.githubNewsletterRepository)
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
