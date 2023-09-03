//
//  LiveActivityViewModel.swift
//  LetSwift
//
//  Created by Dongju on 2023/09/03.
//

import Foundation
import SwiftUI

final class LiveActivityViewModel: ObservableObject {

    func getBackgroundColor(_ isLiveActivityVisible: Bool) -> Color {
        return isLiveActivityVisible ? .gray : .orange

    }
    
    func getTitleText(_ isLiveActivityVisible: Bool) -> String {
        self.toastMessage(isLiveActivityVisible)
        return isLiveActivityVisible ? "그만보기" : "남은거리보기"
    }
    
    private func toastMessage(_ isLiveActivityVisible: Bool){
        if isLiveActivityVisible {
            Toast.shared.show(message: "잠금화면에서 행사장까지의\n남은 거리를 확인해보세요")
        }
    }
}
