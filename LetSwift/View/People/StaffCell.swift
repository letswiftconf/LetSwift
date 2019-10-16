//
//  StaffCell.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/14.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct StaffCell: View {
    var staff: ProtoStaff
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image(staff.name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .mask(Circle())
            VStack(alignment: .center) {
                Text(staff.name)
                    .font(.body)
                    .fontWeight(.bold)
                Text(staff.organization)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
                Text(staff.description)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(2)
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct StaffCell_Previews: PreviewProvider {
    static var previews: some View {
        let layout = PreviewLayout.fixed(width: 320, height: 200)
        let staff = ProtoStaff.makeProtoData()
        return Group {
            StaffCell(staff: staff[5])
                .previewLayout(layout)
            StaffCell(staff: staff[3])
                .previewLayout(layout)
                .environment(\.colorScheme, .dark)
            StaffCell(staff: staff.last!)
                .previewLayout(layout)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .background(Color(.systemBackground))
    }
}
