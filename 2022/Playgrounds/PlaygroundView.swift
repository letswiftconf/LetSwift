//
//  CheeringView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/06.
//

import SwiftUI
import PassKit

struct PlaygroundView: View {
    
    // TODO: Title 부분 색 구현
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing:10) {
                Text("Let's play\n at Swift Playgrounds")
                    .font(.title3Bold)
                    .padding(.leading,10)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 4, y: 4)
                GoToCardView()
                    .padding(.top, 36)
                Text("우리들의 기록")
                    .font(.title3Bold)
                    .padding(.top, 45)
                    .padding(.leading,10)
            }
            .padding(20)
        }
        .navigationTitle("")
        .background(Color.backgroundBlack)
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
