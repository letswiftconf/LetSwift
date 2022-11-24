//
//  Preview.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//
//  Code from https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/

import SwiftUI

// MARK: - View
public extension View {
    func previewAsComponent() -> some View {
        ComponentPreview(component: self)
    }
    
    func previewAsScreen() -> some View {
        ScreenPreview(screen: self)
    }
}

// MARK: - Preview
struct ComponentPreview<Component: View>: View {
    var component: Component
    
    var body: some View {
        #if canImport(UIKit)
        ForEach(values: ColorScheme.allCases) { scheme in
            ForEach(values: ContentSizeCategory.smallestAndLargest) { cardType in
                self.component
                    .previewLayout(.sizeThatFits)
                    .background(Color(UIColor.systemBackground))
                    .colorScheme(scheme)
                    .environment(\.sizeCategory, cardType)
                    .previewDisplayName(
                        "\(scheme.previewName) + \(cardType.previewName)"
                    )
            }
        }
        #else
        ForEach(values: ColorScheme.allCases) { scheme in
            ForEach(values: ContentSizeCategory.smallestAndLargest) { cardType in
                self.component
                    .previewLayout(.sizeThatFits)
                    .background(Color(NSColor.windowBackgroundColor))
                    .colorScheme(scheme)
                    .environment(\.sizeCategory, cardType)
                    .previewDisplayName(
                        "\(scheme.previewName) + \(cardType.previewName)"
                    )
            }
        }
        #endif
    }
}

struct ScreenPreview<Screen: View>: View {
    var screen: Screen
    
    var body: some View {
        #if os(iOS)
        ForEach(values: deviceNames) { device in
            ForEach(values: ColorScheme.allCases) { scheme in
                NavigationView {
                    self.screen
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
                .previewDevice(PreviewDevice(rawValue: device))
                .colorScheme(scheme)
                .previewDisplayName("\(scheme.previewName): \(device)")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        #else
        ForEach(values: deviceNames) { device in
            ForEach(values: ColorScheme.allCases) { scheme in
                NavigationView {
                    self.screen
                }
                .previewDevice(PreviewDevice(rawValue: device))
                .colorScheme(scheme)
                .previewDisplayName("\(scheme.previewName): \(device)")
            }
        }
        #endif
    }
    
    private var deviceNames: [String] {
        [
            "iPhone 12 mini",
            "iPhone 12 Pro Max",
            "iPad Pro (11-inch) (2nd generation)"
        ]
    }
}

// MARK: - Helper
extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}

extension ColorScheme {
    var previewName: String {
        String(describing: self).capitalized
    }
}

extension ContentSizeCategory {
    //    static let smallestAndLargest = [allCases.first!, .medium, allCases.last!]
    static let smallestAndLargest = [Self.medium]
    
    var previewName: String {
        switch self {
        case .extraSmall:
            return "Small"
        case .accessibilityExtraExtraExtraLarge:
            return "Large"
        default:
            return String(describing: self).capitalized
        }
    }
}
