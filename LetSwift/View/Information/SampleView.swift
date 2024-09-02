//
//  SampleView.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/29.
//

import SwiftUI

struct SampleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color.orange)
            .overlay {
                Text("navigationStack sampleView")
            }
    }
}

#Preview {
    SampleView()
}
