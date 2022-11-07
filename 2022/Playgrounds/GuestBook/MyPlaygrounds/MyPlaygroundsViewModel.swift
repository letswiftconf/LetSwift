//
//  MyPlaygroundsViewModel.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/07.
//

import Foundation
import SwiftUI

class MyPlaygroundsViewModel: ObservableObject {
    
}


extension MyPlaygroundsViewModel {
    func getForegroundColor(_ isGuestBookViewHidden: Bool) -> Color {
        return isGuestBookViewHidden ? .gray : .orange
    }
    
    func getContentBySelectedType(_ type: PlaygoundsType) -> String {
        switch type {
        case .guestBook:
            return "오늘 컨퍼런스를 기록해보세요!"
        case .myCard:
            return "나의 playground card 뽑으러가기"
        }
    }
    
    func getNextView(_ type: PlaygoundsType) -> some View {
        switch type {
        case .guestBook:
            return AnyView(GuestBookContentView())
        case .myCard:
            // MARK: -
            return AnyView(GuestBookContentView())
        }
    }
    
}
