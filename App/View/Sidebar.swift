//
//  Sidebar.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct Sidebar: View {
    @State private var selected: Set<SidebarItem> = [.home]
    @State private var presentsSettings = false
    
    enum SidebarItem: Int, Identifiable, CaseIterable {
        case home
        case schedule
        case people
        
        var id: Int {
            return rawValue
        }
        
        var presentingView: some View {
            switch self {
            case .home: return AnyView(HomeView())
            case .schedule: return AnyView(ScheduleView())
            case .people: return AnyView(PeopleView())
            }
        }
        
        var name: String {
            switch self {
            case .home: return "홈"
            case .schedule: return "스케줄"
            case .people: return "사람들"
            }
        }
        
        var imageName: String {
            switch self {
            case .home: return "house.fill"
            case .schedule: return "calendar"
            case .people: return "person.fill"
            }
        }
    }
    
    private var settingsButton: some View {
        Button(action: presentSettings) {
            Image(systemName: "gearshape.2")
        }
    }
    
    // MARK: - Body
    var body: some View {
//        List(SidebarItem.allCases, id: \.self, selection: $selected) { item in
//            if ProcessInfo.processInfo.isMacCatalystApp && item == .home {
//                EmptyView()
//            } else {
//                NavigationLink(destination: item.presentingView) {
//                    Label(item.name, systemImage: item.imageName)
//                }
//                .tag(item)
//            }
//        }
        List() {
            Section(header: Text("Let'Swift 2020")) {
                if !ProcessInfo.processInfo.isMacCatalystApp {
                    NavigationLink(destination: HomeView()) {
                        Label("Home", systemImage: "house.fill")
                    }
                }
                NavigationLink(destination: ScheduleView()) {
                    Label("Schedule", systemImage: "calendar")
                }
//                NavigationLink(destination: TicketView()) {
//                    Label("Ticket", systemImage: "ticket.fill")
//                }
                NavigationLink(destination: PeopleView()) {
                    Label("People", systemImage: "person.fill")
                }
//                NavigationLink(destination: LocationView()) {
//                    Label("Location", systemImage: "map.fill")
//                }
//                NavigationLink(destination: SettingsView()) {
//                    Label("Settings", systemImage: "gearshape.2.fill")
//                }
            }
////            Section(header: Text("Past Events")) {
////                NavigationLink(
////                    destination: Text("Destination"),
////                    label: {
////                        Label("Let'Swift 2019", systemImage: "hammer.fill")
////                    })
////                NavigationLink(
////                    destination: Text("Destination"),
////                    label: {
////                        Label("Let'Swift 2018", systemImage: "hammer.fill")
////                    })
////                NavigationLink(
////                    destination: Text("Destination"),
////                    label: {
////                        Label("Let'Swift 2017", systemImage: "hammer.fill")
////                    })
////            }
        }
        .sheet(isPresented: $presentsSettings) {
            SettingsView()
        }
//        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: settingsButton)
        .listStyle(SidebarListStyle())
        .navigationTitle("Let'Swift") 
    }
    
    // MARK: - Action
    private func presentSettings() {
        presentsSettings.toggle()
    }
}

// MARK: - Preview
struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Sidebar()
        }
        .previewAsScreen()
    }
}
