//
//  Route.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/29.
//

import Foundation

enum HomeRoute: Hashable {
    case sample
    case webView(urlString: String)
}

extension HomeRoute: Identifiable {
    var id: Self { self }
}
