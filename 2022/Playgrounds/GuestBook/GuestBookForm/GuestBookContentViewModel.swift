//
//  GuestBookContentViewModel.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/17.
//

import Foundation
import RxSwift
import RxRelay

class GuestBookContentViewModel {
    
    struct Action {
        var send = PublishRelay<Void>()
        var guestBookList = PublishRelay<Void>()
    }
    
    struct State {
        var receive = PublishRelay<Bool>()
    }
    var action = Action()
    var state = State()
    var disposeBag = DisposeBag()
    private var content = ""
    
    var contents: [GuestBook] = []
    init(){
        binding()
    }
    
    func binding(){
        self.action.send
            .flatMap{
                NetworkService.shared.request(.putComment(contents: self.content, userId: 1), expectingReturnType: ContentsResponse.self)
            }.subscribe(onNext: { [weak self] result in
                guard let self = self else { return  }
                switch result {
                case .success(let response):
                    SharedPreference.shared.user = response
//                    self.state.receive.accept((true))
                    self.action.guestBookList.accept(())
                case .failure(let response):
                    print(response.localizedDescription)
                    self.state.receive.accept((false))
                }
            }).disposed(by: self.disposeBag)
        
        self.action.guestBookList
            .flatMap{
                NetworkService.shared.request(.comment, expectingReturnType: CommentResponse.self)
            }.subscribe(onNext: { [weak self] result in
                guard let self = self else { return  }
                switch result {
                case .success(let response):
//                    self.comments = response
                    SharedPreference.shared.comments = response
                    self.contents = response.guestBooks 
                    self.state.receive.accept((true))
                case .failure(let response):
                    //Local storage data use
                    print(response.localizedDescription)
                    self.state.receive.accept((false))
                }
            }).disposed(by: self.disposeBag)
    }
    
    func setContents(_ content: String) {
        self.content = content
    }
    
    func getMessage(success: Bool) -> String {
        return success ? "후기를 남겨주셔서 감사합니다 :)" : "관리자에게 문의 부탁드립니다 :("
    }
}
