//
//  SettingsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General")) {
                    Text("App Icon")
                    Text("Permissions")
                }
                Section(header: Text("Conference")) {
                    Text("About the Conference")
                    Text("Code of Conduct")
                    Text("Conference Feedback")
                }
                Section(header: Text("Links")) {
                    Text("Let'Swift 2019")
                    Text("Let'Swift 2018")
                    Text("Let'Swift 2017")
                    Text("Let'Swift 2016")
                }
                Section(header: Text("Developer Community")) {
                    Text("OS X Dev.org")
                    Text("Swift Korea Slack")
                    Text("iOS Developers Korea Open Chat")
                }
                Section(header: Text("About")) {
                    Text("Version")
                    Text("Creators")
                    Text("App Feedback")
                    Text("Application Source Code")
                    Text("Open Source Licenses")
                }
                .navigationBarTitle("Settings")
            }
            .listStyle(.grouped)
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
