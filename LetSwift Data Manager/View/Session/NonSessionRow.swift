//
//  NonSessionRow.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 11/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct NonSessionRow: View {
    @ObservedObject var nonsession: NonSession
    
    // MARK: - Formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(nonsession.title)
                .font(.headline)
            Text(nonsession.location)
                .font(.subheadline)
            Text("\(nonsession.timespan.start, formatter: Self.dateFormatter) - \(nonsession.timespan.end, formatter: Self.dateFormatter) ")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(nonsession.description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#if DEBUG
struct NonSessionRow_Previews: PreviewProvider {
    static var previews: some View {
        NonSessionRow(nonsession: NonSession.dummy)
    }
}
#endif
