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
    @StateObject var env: GuestBookEnviromentOjb = GuestBookEnviromentOjb()
    // MARK: - Body
    var body: some View {
        TabView(selection: $selected) {
            ForEach(Tab.allCases) { tab in
                NavigationView {
                    ZStack(alignment: .bottomTrailing) {
                        tab.presentingView
                        buildFloatingButton(tab: tab)
                    }
                }
                .environmentObject(env)
                .tabItem { tab.tabItem }
                .tag(tab)
            }
        }
    }
    
    @ViewBuilder
    func buildFloatingButton(tab: Tab) -> some View {
        ZStack {
            switch tab {
            case .playgrounds:
                VStack {
                    Button {
                        self.showModal = true
                    } label: {
                        ZStack {
                            LottieView(filename: "ic_note")
                                .frame(height: 70)
                            VStack {
                                Text("방명록")
                                    .font(.system(size: 13))
                                Spacer()
                                Text("작성하기")
                                    .font(.system(size: 13))
                            }
                            .padding(.init(top: 2, leading: 0, bottom: 2, trailing: 0))
                        }
                    }
                    .frame(width: 70,height: 70)
                    .opacity(0.7)
                    .background(Color.white)
                    .foregroundColor(Color.orange)
                    .cornerRadius(20)
                    .padding()
                    .fullScreenCover(isPresented: $showModal) {
                        print("dismiss")
                        if env.isSuccess {
                            env.isSuccess = !env.isSuccess
                            Toast.shared.show(message: "컨퍼런스 후기가 등록되었어요", delay: 1.5)
                        }
                    } content: {
                        GuestBookContentView()
                    }
                }
                
            default:
                EmptyView()
            }
        }
    }
}

// MARK: - Tab model
extension TabNavigationView {
    enum Tab: Int, Identifiable, CaseIterable {
        case sessions
        case badges
        case playgrounds
        case settings
        //        case location
        
        // MARK: Identifiable
        var id: Int {
            return rawValue
        }
        
        // MARK:
        var presentingView: some View {
            switch self {
            case .sessions: return AnyView(SessionView())
            case .badges: return AnyView(BadgeView())
            case .playgrounds:
                return AnyView(GuestBookContainerView())
            case .settings: return AnyView(SettingMainView())
//            case .location: return AnyView(LocationView())
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
            case .badges: return "뱃지"
            case .playgrounds: return "놀이터"
            case .settings: return "설정"
//            case .location: return "장소"
            }
        }
        
        private var imageName: String {
            switch self {
            case .sessions: return "calendar"
            case .badges: return "ticket.fill"
            case .playgrounds: return "gamecontroller.fill"
            case .settings: return "gearshape.fill"
//            case .location: return "map.fill"
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
