//
//  GuestBookContainerView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/01.
//

import SwiftUI
import RxSwift

struct GuestBookContainerView: View {
    @StateObject var viewModel = GuestBookListViewModel()
    var disposeBag = DisposeBag()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                TitleView()
                MyPlaygrounds()
                    .background(LinearGradient.gradientOrange.opacity(0.45))
                    .cornerRadius(10)
                    .clipped()
                Section(header: Text("우리들의 기록").font(.title3Bold)) {
                    ForEach(viewModel.getComments() , id: \.id) { event in
                        PlaygroundSimpleRow(guestBook: event)
                            .background(Color.backgroundCell)
                            .cornerRadius(10)
                            .clipped()
                    }
                }
            }
            .padding()
        }
        .padding(.top, 1)
        .foregroundColor(.white)
        .background(Color.backgroundBlack)
        .onAppear{
            self.viewModel.action.guestBookList.accept(())
        }
        
    }
        
}

struct TitleView: View {
    var body: some View {
        VStack (alignment: .leading ){
            HStack(spacing: 0) {
                Text("Let")
                    .font(.title3Bold)
                    .foregroundColor(.orange)
                Text("'s play")
                    .font(.title3Bold)
                    .foregroundColor(.white)
            }
            HStack {
                Text("at")
                    .font(.title3Bold)
                    .foregroundColor(.white)
                Text("Swift")
                    .font(.title3Bold)
                    .foregroundColor(.orange)
                Text("Playgrounds")
                    .font(.title3Bold)
                    .foregroundColor(.white)
            }
        }
    }
}

struct GuestBookContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GuestBookContainerView()
    }
}
