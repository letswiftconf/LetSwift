//
//  MainView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // MARK: - Body
    var body: some View {
        if horizontalSizeClass == .compact {
            TabNavigationView()
        } else {
            SidebarNavigationView()
        }
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewAsScreen()
    }
}
