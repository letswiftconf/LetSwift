//
//  GuestBookListViewModel.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/11.
//

import Foundation
import RxSwift
import RxRelay

class GuestBookListViewModel: ObservableObject {
    var titleString: String = ""
    @Published var comments: CommentResponse?

    
    struct Action {
        var guestBookList = PublishRelay<Void>()
    }
    
    struct State {
        var receiveData = PublishRelay<Void>()
    }
    var action = Action()
    var state = State()
    var disposeBag = DisposeBag()
    
    init(){
        titleString = """
            \("Let' play".convertString(text: "Let"))
            \("at Swift Playgrounds".convertString(text: "Swift"))
        """
        binding()
    }
    
    func binding(){
        self.action.guestBookList
            .flatMap{
                NetworkService.shared.request(.comment, expectingReturnType: CommentResponse.self)
            }.subscribe(onNext: { [weak self] result in
                guard let self = self else { return  }
                switch result {
                case .success(let response):
                    print("\(response)")
                    self.comments = response
                    SharedPreference.shared.comments = response
//                    self.state.receiveData.accept(())
                case .failure(let response):
                    //Local storage data use
                    print(response.localizedDescription)
                    self.comments = SharedPreference.shared.comments
                }
            }).disposed(by: self.disposeBag)
    }
}

extension GuestBookListViewModel {
    func getComments() -> [GuestBook] {
        guard let comments = self.comments else  {
            return []
        }
        
        return comments.guestBooks
    }
}
