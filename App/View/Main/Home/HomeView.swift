//
//  HomeView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI
import PassKit

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var presentsSettings = false
    @State private var presentsAddPass = false
    
    private var settingsButton: some View {
        Button(action: presentSettings) {
            Image(systemName: "gearshape.2")
        }
    }
    
    private var addPassView: some View {
        guard let fileURL = Bundle.main.url(forResource: "LetSwift", withExtension: "pkpass") else {
            return AnyView(EmptyView())
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            return AnyView(EmptyView())
        }
        guard let pass = try? PKPass(data: data) else {
            return AnyView(EmptyView())
        }
        return AnyView(AddPassView(pass: pass))
    }
    
    // MARK: - Body
    var body: some View {
        let home = ScrollView {
            VStack(spacing: .homeItemVSpacing) {
                HeroItemView(height: .homeItemHeight)
                GeometryReader { geometry in
                    let width = (geometry.size.width - CGFloat.homeItemHSpacing) / 2
                    let height = geometry.size.height
                    HStack(spacing: .homeItemHSpacing) {
                        GetTicketItemView(width: width, height: height)
                        AskQuestionItemView(width: width, height: height)
                    }
                }
                .frame(height: .homeItemHeight)
                if PKAddPassesViewController.canAddPasses() && DateManager.isPassAvailable() {
                    AddPassButton()
                        .frame(height: 60)
                        .onTapGesture {
                            presentAddPass()
                        }
                        .sheet(isPresented: $presentsAddPass) {
                            addPassView
                        }
                }
                NewsletterItemView(height: .homeItemHeight)
                GeometryReader { geometry in
                    let width = (geometry.size.width - CGFloat.homeItemHSpacing) / 2
                    let height = geometry.size.height
                    HStack(spacing: .homeItemHSpacing) {
                        AppSourceCodeItemView(width: width, height: height)
                        WebSourceCodeItemView(width: width, height: height)
                    }
                }
                .frame(height: .homeItemHeight)
//                PastEventItemView(height: .homeItemHeight)
                EmptyView()
                    .sheet(isPresented: $presentsSettings) {
                        SettingsView()
                    }
            }
            .padding(.horizontal)
        }
        .navigationTitle("홈")
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return AnyView(home.navigationBarItems(trailing: settingsButton))
        } else {
            return AnyView(home.navigationBarItems(trailing: EmptyView()))
        }
        #else
        return AnyView(home)
        #endif
    }
    
    // MARK: - Action
    private func presentSettings() {
        presentsSettings.toggle()
    }
    
    private func presentAddPass() {
        presentsAddPass.toggle()
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
        .previewAsComponent()
    }
}
