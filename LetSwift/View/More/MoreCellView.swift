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
        HStack {
            Button {
                onClickEvent(cell.type)
            } label: {
                Text(cell.title)
                    .font(.medium(size: 16))
                    .foregroundStyle(Color.whiteText)
                
                Spacer()
                
                Image("ic_forward")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 17)
        .frame(maxWidth: .infinity)
        .frame(height: 58)
        .background(Color.darkBackground)
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
