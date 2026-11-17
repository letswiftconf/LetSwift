//
//  InvertLabView.swift
//  LetSwift
//
//  TEMPORARY: side-by-side Smart Invert experiments for simulator screenshots.
//  Lives only on the thread branch. Never merge this file into a develop branch.
//

import Foundation
import SwiftUI
import UIKit

/// Reads the `INVERT_LAB` environment variable, which picks a test screen at launch.
enum InvertLab {
    static let mode: String? = ProcessInfo.processInfo.environment["INVERT_LAB"]

    static var isLabScreen: Bool { mode?.hasPrefix("lab") ?? false }

    static var initialTab: TabItem {
        switch mode {
        case "videos", "detail": .previous
        case "more", "appicon": .more
        default: .home
        }
    }
}

struct InvertLabView: View {
    /// "lab" (list thumbnails), "lab2" (glass play button), "lab3" (bundled images).
    let page: String

    @Environment(\.accessibilityInvertColors) private var invertColors
    @Environment(\.colorScheme) private var colorScheme

    private let still = URL(string: "https://i.ytimg.com/vi/UHh7NzGuaRM/mqdefault.jpg")
    private let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(verbatim: "\(page) | env.invert=\(invertColors) | UIAccessibility.invert=\(UIAccessibility.isInvertColorsEnabled) | \(colorScheme == .dark ? "dark" : "light")")
                    .font(.caption2.monospaced())

                switch page {
                case "lab2": glassPage
                case "lab3": assetPage
                default: thumbnailPage
                }

                LazyVGrid(columns: columns, spacing: 10) {
                    specimen("S1 swatches, not flagged") { LabSwatches() }
                    specimen("S2 swatches, flagged") { LabSwatches().accessibilityIgnoresInvertColors() }
                }
            }
            .padding(12)
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Pages

    private var thumbnailPage: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            specimen("A1 nothing flagged") {
                LabThumb(url: still, badge: false)
            }
            specimen("A2 image only") {
                LabThumb(url: still, imageFlagged: true, badge: false)
            }
            specimen("A3 image + badge, each") {
                LabThumb(url: still, imageFlagged: true, badge: true)
            }
            specimen("A4 whole thumbnail") {
                LabThumb(url: still, badge: false, wholeFlagged: true)
            }
            specimen("A5 whole + image (nested)") {
                LabThumb(url: still, imageFlagged: true, badge: true, wholeFlagged: true)
            }
            specimen("A6 real VideoThumbnail") {
                VideoThumbnail(
                    video: Video(id: "UHh7NzGuaRM", title: "", speaker: nil, duration: nil, slides: nil),
                    cornerRadius: 8,
                    showsPlayBadge: true
                )
            }
            specimen("B1 placeholder, nothing") {
                LabThumb(url: nil, badge: false)
            }
            specimen("B2 placeholder, badge flagged") {
                LabThumb(url: nil, imageFlagged: true, badge: true)
            }
            specimen("B3 placeholder, whole") {
                LabThumb(url: nil, badge: false, wholeFlagged: true)
            }
            specimen("S3 swatches, flagged twice") {
                LabSwatches()
                    .accessibilityIgnoresInvertColors()
                    .accessibilityIgnoresInvertColors()
            }
        }
    }

    private var glassPage: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            specimen("C1 nothing flagged") {
                LabThumb(url: still, glass: false)
            }
            specimen("C2 image only") {
                LabThumb(url: still, imageFlagged: true, glass: false)
            }
            specimen("C3 image + glass, each") {
                LabThumb(url: still, imageFlagged: true, glass: true)
            }
            specimen("C4 whole (image + glass)") {
                LabThumb(url: still, glass: false, wholeFlagged: true)
            }
            specimen("C5 placeholder, nothing") {
                LabThumb(url: nil, glass: false)
            }
            specimen("C6 placeholder, glass flagged") {
                LabThumb(url: nil, glass: true)
            }
            specimen("C7 placeholder, whole") {
                LabThumb(url: nil, glass: false, wholeFlagged: true)
            }
            specimen("C8 swatches + glass, each") {
                LabSwatches(height: 100)
                    .accessibilityIgnoresInvertColors()
                    .overlay { LabGlassButton().accessibilityIgnoresInvertColors() }
            }
            specimen("C9 swatches + glass, whole") {
                LabSwatches(height: 100)
                    .overlay { LabGlassButton() }
                    .accessibilityIgnoresInvertColors()
            }
            specimen("C10 swatches + glass, none") {
                LabSwatches(height: 100)
                    .overlay { LabGlassButton() }
            }
        }
    }

    private var assetPage: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            specimen("D1 icon, not flagged") {
                icon
            }
            specimen("D2 icon, flagged") {
                icon.accessibilityIgnoresInvertColors()
            }
            specimen("D3 flagged, then shadow") {
                icon
                    .accessibilityIgnoresInvertColors()
                    .shadow(color: .black.opacity(0.15), radius: 3)
            }
            specimen("D4 shadow, then flagged") {
                icon
                    .shadow(color: .black.opacity(0.15), radius: 3)
                    .accessibilityIgnoresInvertColors()
            }
            specimen("D5 real AppIconPreview") {
                AppIconPreview(imageName: "AppIcon_preview", iconName: "appIcon.default")
            }
            specimen("D6 theme color, not flagged") {
                Color.themePrimary.frame(height: 40)
            }
            specimen("D7 theme color, flagged") {
                Color.themePrimary.frame(height: 40).accessibilityIgnoresInvertColors()
            }
            specimen("D8 dimmed spinner") {
                ZStack {
                    Color.black.opacity(0.3)
                    ProgressView().tint(.white)
                }
                .frame(height: 60)
            }
        }
    }

    private var icon: some View {
        Image("AppIcon_preview")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64, height: 64)
    }

    private func specimen(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            content()
            Text(verbatim: title)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
}

/// Copy of `VideoThumbnail`'s layers with every Smart Invert choice switchable.
private struct LabThumb: View {
    var url: URL?
    var imageFlagged = false
    /// `nil`: no badge. Otherwise whether the badge itself is flagged.
    var badge: Bool?
    /// `nil`: no glass play button. Otherwise whether the button itself is flagged.
    var glass: Bool?
    var wholeFlagged = false

    var body: some View {
        Color(.systemGray5)
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .accessibilityIgnoresInvertColors(imageFlagged)
                } placeholder: {
                    Image(systemName: "play.rectangle")
                        .font(.title2)
                        .foregroundStyle(.tertiary)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if let badge {
                    Image(systemName: "play.fill")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(6)
                        .background(.black.opacity(0.6), in: Circle())
                        .padding(6)
                        .accessibilityIgnoresInvertColors(badge)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                if let glass {
                    LabGlassButton()
                        .accessibilityIgnoresInvertColors(glass)
                }
            }
            .accessibilityIgnoresInvertColors(wholeFlagged)
    }
}

/// Same button as the one on the video detail screen.
private struct LabGlassButton: View {
    var body: some View {
        Image(systemName: "play.fill")
            .font(.title)
            .foregroundStyle(.white)
            .frame(width: 64, height: 64)
            .glassEffect(.regular.interactive(), in: Circle())
    }
}

/// Fixed sRGB colors, so the screenshots show at a glance whether something is inverted.
private struct LabSwatches: View {
    var height: CGFloat = 24

    private let colors: [Color] = [
        Color(red: 1, green: 0, blue: 0),
        Color(red: 0, green: 1, blue: 0),
        Color(red: 0, green: 0, blue: 1),
        Color(red: 1, green: 1, blue: 0),
        Color(red: 1, green: 1, blue: 1),
        Color(red: 0, green: 0, blue: 0),
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(colors.indices, id: \.self) { index in
                colors[index]
            }
        }
        .frame(height: height)
    }
}
