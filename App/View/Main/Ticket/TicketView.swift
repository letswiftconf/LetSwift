//
//  TicketView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct TicketView: View {
    var body: some View {
        Text("Ticket")
            .navigationTitle("Ticket")
    }
}

// MARK: - Preview
struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TicketView()
        }
        .previewAsScreen()
    }
}
