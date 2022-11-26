//
//  OnAirIconView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/27.
//

import SwiftUI

struct OnAirIconView: View {
    var body: some View {
        HStack {
            Image(systemName: "dot.radiowaves.left.and.right")
            Text("LIVE")
                .fontWeight(.bold)
        }
        .font(.caption)
        .foregroundColor(.white)
        .padding(4)
        .background(Color.red)
        .cornerRadius(6)
    }
}

// MARK: - Preview
struct OnAirIconView_Previews: PreviewProvider {
    static var previews: some View {
        OnAirIconView()
            .previewAsComponent()
    }
}
