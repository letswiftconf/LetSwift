//
//  GuestBookEnviromentOjb.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/17.
//

import Foundation
import Combine
import RxSwift
import RxRelay

class GuestBookEnviromentOjb: ObservableObject {
    @Published var contents: [GuestBook] = []
    @Published var userContent = "no comments"

}
