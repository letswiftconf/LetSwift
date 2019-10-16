//
//  AllPeopleList.swift
//  LetSwift
//
//  Created by 김나용 on 15/10/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import Foundation
import SwiftUI

struct AllPeopleList: View {
    
    let title: String
    let speakers: [ProtoSpeaker]
    var columnCount: Int = 3
    var hPadding: CGFloat = 16
    var hSpacing: CGFloat = 16
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                self.grid(geometry: geometry)
                    .padding(.vertical)
            }
        }
        .navigationBarTitle(title)
    }
    
    // MARK: - Body Builder
    
    func grid(geometry: GeometryProxy) -> some View {
        let filledRowCount = speakers.count / columnCount
        
        return VStack(alignment: .center) {
            ForEach(0..<filledRowCount) { index in
                self.row(at: index, geometry: geometry)
            }
            if self.speakers.count % self.columnCount > 0 {
                self.row(at: filledRowCount, isLast: true, geometry: geometry)
            }
        }
    }
    
    func row(at rowIndex: Int, isLast: Bool = false, geometry: GeometryProxy) -> some View {
        let itemCount = isLast ? speakers.count % columnCount : columnCount
        
        return HStack(spacing: hSpacing) {
            ForEach(0..<itemCount) { columnIndex in
                SpeakerCell(speaker: self.speakers[(rowIndex * self.columnCount) + columnIndex])
                    .frame(width: self.cellWidth(geometry))
            }
            if isLast {
                Spacer()
            }
        }
        .padding([.horizontal], hPadding)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    // MARK: - Helper Functions
    
    func cellWidth(_ geometry: GeometryProxy) -> CGFloat {
        let spacing = CGFloat(columnCount - 1) * hSpacing + (2 * hPadding)
        return (geometry.size.width - spacing) / CGFloat(columnCount)
    }
}

// MARK: - Preview
struct AllPeopleList_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 240)
        return Group {
            PeopleList(title: "Section", speakers: ProtoSpeaker.speakers)
                .previewLayout(layout)
            PeopleList(title: "Section", speakers: ProtoSpeaker.speakers)
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            PeopleList(title: "Section", speakers: ProtoSpeaker.speakers)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
