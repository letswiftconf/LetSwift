//
//  AppIconView.swift
//  LetSwift
//
//  Created by BumMo Koo on 10/12/25.
//

import SwiftUI

struct AppIconView: View {
    var body: some View {
        List {
            Button {
                UIApplication.shared.setAlternateIconName(nil)
            } label: {
                AppIconPreview(imageName: "AppIcon_preview", iconName: "appIcon.default")
            }
            Button {
                UIApplication.shared.setAlternateIconName("AppIcon_Alt")
            } label: {
                AppIconPreview(imageName: "AppIcon_Alt_preview", iconName: "appIcon.alternative")
            }
            Button {
                UIApplication.shared.setAlternateIconName("AppIcon_2025")
            } label: {
                AppIconPreview(imageName: "AppIcon_2025_preview", iconName: "appIcon.2025")
            }
        }
        .buttonStyle(.plain)
        .listStyle(.insetGrouped)
        .navigationTitle("settings.appIcon")
    }
}

struct AppIconPreview: View {
    let imageName: String
    let iconName: LocalizedStringResource
    
    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .shadow(color: .black.opacity(0.15), radius: 3)
            Text(iconName)
                .fontWeight(.semibold)
            Spacer()
        }
        .contentShape(.rect)
    }
}

#Preview {
    NavigationStack {
        AppIconView()
    }
}
