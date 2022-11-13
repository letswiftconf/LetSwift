//
//  NetworkProvider.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Moya
import RxSwift

public class NetworkProvider {
    
    lazy var provider = MoyaProvider<LetSwiftAPI>(plugins: [RequestLoggingPlugin(), networkPlugin])
    
    let networkPlugin: NetworkActivityPlugin
    
    public init(_ networkPlugin: NetworkActivityPlugin = NetworkActivityPlugin { _, _ in }) {
        self.networkPlugin = networkPlugin
    }
    
    public func request(_ target: LetSwiftAPI) -> PrimitiveSequence<SingleTrait, Response> {
        return provider.rx.request(target)
    }
    
}

