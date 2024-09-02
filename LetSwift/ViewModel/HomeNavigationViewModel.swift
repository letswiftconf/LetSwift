//
//  NavigationViewModel.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/29.
//

import Foundation

class HomeNavigationViewModel: ObservableObject {
    @Published var presentedRoutes: [HomeRoute]
    
    init(presentedRoutes: [HomeRoute] = []) {
        self.presentedRoutes = presentedRoutes
    }
    
    /// 새로운 화면 navigationStack에 넣기
    /// - Parameter newRoute: 넣으려고 하는 화면
    func push(to newRoute: HomeRoute) {
        self.presentedRoutes.append(newRoute)
    }
    
    /// 가장 마지막화면 스택에서 삭제
    func pop() {
        self.presentedRoutes.removeLast()
    }
    
    /// 스택에 있는 모든 화면 삭제
    func removeAll() {
        self.presentedRoutes.removeAll()
    }
    
    /// 스택에 있는 특정 화면 삭제
    /// - Parameter removingRoute: 삭제하고 싶은 화면
    func removeCertainRoute(removingRoute: HomeRoute) {
        let filteredRoutes = self.presentedRoutes.filter { route in
            return route != removingRoute
        }
        self.presentedRoutes = filteredRoutes
    }
}
