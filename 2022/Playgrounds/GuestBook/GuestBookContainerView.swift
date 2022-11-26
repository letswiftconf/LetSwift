//
//  GuestBookContainerView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/01.
//

import SwiftUI
import RxSwift
import Combine

struct GuestBookContainerView: View {
    @EnvironmentObject var env: GuestBookEnviromentOjb
    @ObservedObject var viewModel = GuestBookListViewModel()
    @State private var showModal = false
    var disposeBag = DisposeBag()
    @State var selected = 0
    var body: some View {
        ScrollView {
            
                VStack(alignment: .leading, spacing: 20) {
                    TitleView()
                    //MyPlaygrounds
                    GoToCardView()
                        .background(LinearGradient.gradientOrange.opacity(0.45))
                        .cornerRadius(10)
                        .clipped()
                    Section(header: Text("우리들의 기록").font(.title3Bold)) {
                        ForEach(env.contents.reversed() , id: \.self) { event in
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
        .onWillAappear {
            self.viewModel.action.guestBookList.accept(())
            setupRX()
        }
        
    }
    
    func setupRX(){
        self.viewModel.state.receiveData
            .subscribe(onNext: { data in
                env.contents = data
            })
            .disposed(by: disposeBag)
    }
}

struct TitleView: View {
    var body: some View {
        VStack (alignment: .leading ){
            HStack(spacing: 0) {
                Text("Let")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Text("'s play")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            HStack {
                Text("at")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Swift")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Text("Playgrounds")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
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
