//
//  LiveActivityViewModel.swift
//  LetSwift
//
//  Created by Dongju on 2023/09/03.
//

import Foundation
import SwiftUI

final class LiveActivityViewModel: ObservableObject {
    
    func getBackgroundColor(_ isLiveActivityVisible: Bool?) -> Color {
        self.toastMessage(isLiveActivityVisible)
        return .white.opacity(0.0)
    }

    private func toastMessage(_ isLiveActivityVisible: Bool?){
        guard let isLiveActivityVisible = isLiveActivityVisible else { return }
        let text = isLiveActivityVisible ? "잠금화면에서 행사장까지의\n남은 거리를 확인해보세요" : "라이브 액티비티 기능을 종료합니다."
        Toast.shared.show(message: text)
    }
}
