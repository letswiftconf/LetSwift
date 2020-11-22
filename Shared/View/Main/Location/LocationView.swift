//
//  LocationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Meet us online")
            }
        }
        .navigationTitle("Location")
    }
}

// MARK: - Preview
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationView()
        }
        .previewAsScreen()
    }
}
