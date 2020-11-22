//
//  TitleDetailCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/08.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct TitleDetailCell: View {
    let title: String
    let description: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(description)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
struct TitleDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            List {
                TitleDetailCell(title: "Title 1", description: "Description")
                TitleDetailCell(title: "Title 2", description: "Description")
                TitleDetailCell(title: "Title 3", description: "Description")
            }
            List {
                TitleDetailCell(title: "Title 1", description: "Description")
                TitleDetailCell(title: "Title 2", description: "Description")
                TitleDetailCell(title: "Title 3", description: "Description")
            }
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.fixed(width: 320, height: 180))
    }
}
