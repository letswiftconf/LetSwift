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

    struct Action {
        var guestBookList = PublishRelay<Void>()
    }
    
    struct State {
        var receiveData = PublishRelay<[GuestBook]>()
    }
    var action = Action()
    var state = State()
    var disposeBag = DisposeBag()
    
    init(){
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
                    
                    SharedPreference.shared.comments = response
                    self.state.receiveData.accept(response.guestBooks)
                case .failure(let response):
                    //Local storage data use
                    print(response.localizedDescription)
                    
                    self.state.receiveData.accept(SharedPreference.shared.comments?.guestBooks ?? [])
                }
            }).disposed(by: self.disposeBag)
    }
}
