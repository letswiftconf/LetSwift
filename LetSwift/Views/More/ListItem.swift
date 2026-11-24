//
//  ListItem.swift
//  LetSwift
//
//  Created by BumMo Koo on 10/11/25.
//

import SwiftUI

enum ListItemStyle {
    case none, disclosureIndicator, externalLink
}

struct ListItem: View {
    let title: LocalizedStringResource
    let style: ListItemStyle
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            switch style {
            case .none:
                EmptyView()
            case .disclosureIndicator:
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
            case .externalLink:
                Image(systemName: "arrow.up.right")
                    .foregroundStyle(.tertiary)
                    .accessibilityHidden(true)
            }
        }
        .contentShape(.rect)
    }
}

extension View {
    /// Makes VoiceOver announce a row that opens a web page as a link, which is what the ↗ icon tells sighted users.
    func accessibilityExternalLink() -> some View {
        accessibilityRemoveTraits(.isButton)
            .accessibilityAddTraits(.isLink)
    }
}
