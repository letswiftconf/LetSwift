//
//  SettingsCellView.swift
//  LetSwift
//
//  Created by Philip Chung on 9/2/24.
//

import SwiftUI

struct SettingsCellView: View {
    typealias Cell = Settings.Section.Cell
    
    private let cell: Cell
    private let onClickEvent: (_ type: Cell.CellType) -> ()
    
    init(
        cell: Settings.Section.Cell,
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

#Preview("SettingsCellView", traits: .fixedLayout(width: 500, height: 60)) {
    SettingsCellView(cell: Settings.Section.Cell.sampleCell) { _ in
        print("Clicked")
    }
}

extension Settings.Section.Cell {
    fileprivate static let sampleCell = Settings.data.sections[0].cells[0]
}
