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
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
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
        let conference = Conference(title: "Let\'Swift",
                                    description: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam.",
                                    date: Date(),
                                    schedule: Schedule(sessions: [],
                                                       nonsessions: []),
                                    participants: [])
        return ConferenceRow(conference: conference)
    }
}
#endif
