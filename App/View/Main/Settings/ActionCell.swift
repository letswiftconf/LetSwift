//
//  ActionCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/08.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ActionCell: View {
    let title: String
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            self.action()
        }) {
            #if os(iOS)
            Text(title)
                .foregroundColor(Color(.label))
            #else
            Text(title)
                .foregroundColor(Color(.labelColor))
            #endif
        }
    }
}

// MARK: - Preview
struct ActionCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            List {
                ActionCell(title: "Action 1") { }
                ActionCell(title: "Action 2") { }
                ActionCell(title: "Action 3") { }
            }
            List {
                ActionCell(title: "Action 1") { }
                ActionCell(title: "Action 2") { }
                ActionCell(title: "Action 3") { }
            }
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.fixed(width: 320, height: 180))
    }
}
