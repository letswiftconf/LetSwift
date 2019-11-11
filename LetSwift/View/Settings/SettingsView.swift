//
//  SettingsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var presentModal = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("일반")) {
                    permissionCell
                }
                Section(header: Text("행사")) {
                    openHomepageCell
                    openWebSourceCodeCell
                }
                Section(header: Text("이 앱에 관하여"), footer: footer) {
                    versionCell
                    writeReviewCell
                    openAppFeedbackCell
                    openAppSourceCodeCell
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: doneButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - View components
    private var doneButton: some View {
        Button(action: dismiss) {
            Text("Done")
        }
        .accentColor(Color(.themePrimary))
    }
    
    private var openHomepageCell: some View {
        ActionCell(title: "공식 홈페이지") {
            self.presentModal.toggle()
        }
        .sheet(isPresented: $presentModal) {
            Safari(url: URL(string: "http://letswift.kr/")!)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var openWebSourceCodeCell: some View {
        ActionCell(title: "웹사이트 소스코드") {
            self.presentModal.toggle()
        }
        .sheet(isPresented: $presentModal) {
            Safari(url: URL(string: "https://github.com/letswiftconf/letswift.kr")!)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var openAppFeedbackCell: some View {
        ActionCell(title: "앱 피드백") {
            self.presentModal.toggle()
        }
        .sheet(isPresented: $presentModal) {
            Safari(url: URL(string: "https://github.com/cleanios/LetSwift/issues")!)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var openAppSourceCodeCell: some View {
        ActionCell(title: "앱 소스코드") {
            self.presentModal.toggle()
        }
        .sheet(isPresented: $presentModal) {
            Safari(url: URL(string: "https://github.com/cleanios/LetSwift")!)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var permissionCell: some View {
        ActionCell(title: "권한 설정") {
            GlobalAction.openAppSettings()
        }
    }
    
    private var writeReviewCell: some View {
        ActionCell(title: "리뷰 쓰기") {
            GlobalAction.openWriteReivew()
        }
    }
    
    private var versionCell: some View {
        TitleDetailCell(title: "버전",
                        description: UIApplication.shared.versionString)
    }
    
    private var footer: some View {
        HStack {
            Spacer()
            AppInfoView()
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Action
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
            SettingsView()
                .environment(\.colorScheme, .dark)
            SettingsView()
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}

