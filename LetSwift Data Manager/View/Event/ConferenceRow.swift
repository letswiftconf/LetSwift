//
//  ConferenceRow.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 08/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ConferenceRow: View {
    @ObservedObject var conference: Conference
    
    // MARK: - Formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(conference.title)
                .font(.headline)
            Text("\(conference.date, formatter: Self.dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(conference.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
    }
}

#if DEBUG
struct ConferenceRow_Previews: PreviewProvider {
    static var previews: some View {
        return ConferenceRow(conference: Conference.dummy)
    }
}
#endif
