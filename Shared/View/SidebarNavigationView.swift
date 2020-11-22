//
//  SidebarNavigationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct SidebarNavigationView: View {
    var body: some View {
        NavigationView {
            Sidebar()
            Text("Detail View")
        }
    }
}

// MARK: - Preview
struct SidebarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarNavigationView()
            .previewAsScreen()
    }
}
