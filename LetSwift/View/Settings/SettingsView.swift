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
                    SafariNavigationLink(title: "Let'Swift 2018", url: URL(string: "http://letswift.kr/2018"))
                    SafariNavigationLink(title: "Let'Swift 2017", url: URL(string: "http://letswift.kr/2017"))
                    SafariNavigationLink(title: "Let'Swift 2016", url: URL(string: "http://letswift.kr/2016"))
                }
                Section(header: Text("Developer Community")) {
                    SafariNavigationLink(title: "OSXDev.org", url: URL(string: "http://www.osxdev.org/forum/index.php"))
                    SafariNavigationLink(title: "Swift Korea Facebook", url: URL(string: "https://www.facebook.com/groups/swiftkor/"))
                    SafariNavigationLink(title: "Swift Korea Slack", url: URL(string: "http://slack.swiftkorea.org"))
                    SafariNavigationLink(title: "iOS Developers KR Open Chat", url: URL(string: "https://open.kakao.com/o/gyLape"))
                }
                Section(header: Text("About")) {
                    Text("Version")
                    Text("Creators")
                    SafariNavigationLink(title: "App Feedback", url: URL(string: "https://github.com/cleanios/LetSwift/issues"))
                    SafariNavigationLink(title: "App Source Code", url: URL(string: "https://github.com/cleanios/LetSwift"))
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
