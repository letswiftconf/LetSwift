//
//  AppIconView.swift
//  LetSwift
//
//  Created by BumMo Koo on 10/12/25.
//

import SwiftUI

struct AppIconView: View {
    @State private var presentError = false
    
    var body: some View {
        List {
            Button {
                UIApplication.shared.setAlternateIconName(nil) { error in
                    if let _ = error {
                        presentError = true
                    }
                }
            } label: {
                AppIconPreview(imageName: "AppIcon_preview", iconName: "appIcon.default")
            }
            Button {
                UIApplication.shared.setAlternateIconName("AppIcon_Alt") { error in
                    if let _ = error {
                        presentError = true
                    }
                }
            } label: {
                AppIconPreview(imageName: "AppIcon_Alt_preview", iconName: "appIcon.alternative")
            }
            Button {
                UIApplication.shared.setAlternateIconName("AppIcon_2025") { error in
                    if let _ = error {
                        presentError = true
                    }
                }
            } label: {
                AppIconPreview(imageName: "AppIcon_2025_preview", iconName: "appIcon.2025")
            }
        }
        .buttonStyle(.plain)
        .listStyle(.insetGrouped)
        .navigationTitle("settings.appIcon")
        .alert("appIcon.error", isPresented: $presentError) {
            Button("alert.confirm", role: .cancel) {}
        }
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
