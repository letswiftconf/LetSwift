//
//  SessionRow.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 10/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SessionRow: View {
    @ObservedObject var session: Session
    
    // MARK: - Formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .foregroundColor(.secondary)
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(session.title)
                    .font(.headline)
                Text(session.speaker.profile.preferredName)
                    .font(.subheadline)
                Text(session.location)
                    .font(.subheadline)
                Text(session.track.localizedName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(session.timespan.start, formatter: Self.dateFormatter) - \(session.timespan.end, formatter: Self.dateFormatter) ")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(session.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#if DEBUG
struct SessionRow_Previews: PreviewProvider {
    static var previews: some View {
        SessionRow(session: Session.dummy)
    }
}
#endif
