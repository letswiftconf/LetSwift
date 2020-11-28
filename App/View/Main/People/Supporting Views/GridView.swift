//
//  GridView.swift
//  LetSwift
//
//  Created by 신한섭 on 2020/11/23.
//

import SwiftUI

struct GridView<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int) -> Content
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(alignment: .top) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row * self.columns + column)
                        if column + 1 != self.columns {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
