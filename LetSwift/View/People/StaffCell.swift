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
                    .foregroundColor(Color(.label))
                Text(staff.organization)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.secondaryLabel))
                if staff.tags.count > 0 {
//                    HStack {
//                        ForEach(staff.tags, id: \.self) { tag in
//                            Text("#" + tag)
//                                .font(.system(size: 8))
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color(.secondaryLabel))
//                        }
//                    }
                    Text("#" + staff.tags[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.themeSecondary))
                }
            }
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Preview
struct StaffCell_Previews: PreviewProvider {
    static var previews: some View {
        let staff = ProtoStaff.makeProtoData()
        return Group {
            StaffCell(staff: staff[2])
            StaffCell(staff: staff[3])
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
            StaffCell(staff: staff[1])
            StaffCell(staff: staff.last!)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
        .padding()
            //        .previewLayout(.sizeThatFits)
            .previewLayout(.fixed(width: 100, height: 150))
    }
}
