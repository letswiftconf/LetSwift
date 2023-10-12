//
//  TabNavigationView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI

struct TabNavigationView: View {
    @State private var selected: Tab = .sessions
    @State private var showModal = false
//
    
      
    // MARK: - Body
    var body: some View {
        NavigationStack {
            TabView(selection: $selected) {
                ForEach(Tab.allCases) { tab in
                    ZStack(alignment: .bottomTrailing) {
                        tab.presentingView
//                        buildFloatingButton(tab: tab)
                    }
                    .tabItem { tab.tabItem }
                    .tag(tab)
                }
            }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().barTintColor = UIColor(Color.backgroundBlack)
        }
    }
    
    /*
    @ViewBuilder
    func buildFloatingButton(tab: Tab) -> some View {
        ZStack {
            switch tab {
            case .sessions:
//                if #available(iOS 16.1, *) {
                    SessionFloatingButton()
//                    .environment(notifier)
                
//                }
            default:
                EmptyView()
            }
        }
        .padding()
    }
     */
}

// MARK: - Tab model
extension TabNavigationView {
    enum Tab: Int, Identifiable, CaseIterable {
        case sessions
        case people
        case playgrounds
        case camera
        case settings
        
        
        // MARK: Identifiable
        var id: Int {
            return rawValue
        }
        
        // MARK:
        var presentingView: some View {
            switch self {
            case .sessions: return AnyView(SessionView())
            case .people: return AnyView(SettingMainView())
            case .playgrounds:
                return AnyView(GoToCardView())
            case .camera: return AnyView(SelfieCameraView())
            case .settings: return AnyView(SettingView())
            
            }
        }
        
        var tabItem: some View {
            Group {
                Text(name)
                Image(systemName: imageName)
            }
        }
        
        private var name: String {
            switch self {
            case .sessions: return "세션"
            case .people: return "연사자&준비위원"
            case .playgrounds: return "놀이터"
            case .camera: return "카메라"
            case .settings: return "설정"
            
            }
        }
        
        private var imageName: String {
            switch self {
            case .sessions: return "calendar"
            case .people: return "person.2.fill"
            case .playgrounds: return "gamecontroller.fill"
            case .camera: return "rectangle.on.rectangle"
            case .settings: return "gearshape.fill"
            }
        }
    }
}

// MARK: - Preview
struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
            .previewAsScreen()
    }
}
