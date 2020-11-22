//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                Placeholder()
                Text("Header")
                Text("Catch phrase")
                Text("Others")
                Text("Ticket")
                Text("Newsletter")
                Text("Past Events")
                Text("Brought to you by")
                Text("Open Source App")
                Text("Open Source Web")
            }
        }
        .navigationTitle("Home")
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
        .previewAsScreen()
    }
}
