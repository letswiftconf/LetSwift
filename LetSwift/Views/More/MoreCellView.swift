//
//  MoreCellView.swift
//  LetSwift
//
//  Created by Philip Chung on 9/2/24.
//

import SwiftUI

struct MoreCellView: View {
    typealias Cell = More.Section.Cell
    
    private let cell: Cell
    private let onClickEvent: (_ type: Cell.CellType) -> ()
    
    init(
        cell: Cell,
        onClickEvent: @escaping (_ type: Cell.CellType) -> Void
    ) {
        self.cell = cell
        self.onClickEvent = onClickEvent
    }
    
    var body: some View {
        Button {
            onClickEvent(cell.type)
        } label: {
            HStack {
                Text(cell.title)
                Spacer()
                Image("ic_forward")
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview("MoreCellView", traits: .fixedLayout(width: 500, height: 60)) {
    MoreCellView(cell: More.Section.Cell.sampleCell) { _ in
        print("Clicked")
    }
}

extension More.Section.Cell {
    fileprivate static let sampleCell = More.data.sections[0].cells[0]
}
