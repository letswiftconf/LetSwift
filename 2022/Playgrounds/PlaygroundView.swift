//
//  CheeringView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI
import PassKit

struct PlaygroundView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing:10) {
                GoToCardView()
            }
            .padding(20)
        }
        .navigationTitle("놀이터")
    }
}

// MARK: - Preview
struct CheeringView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
        .previewAsComponent()
    }
}
