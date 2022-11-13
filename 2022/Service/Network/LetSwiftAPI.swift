//
//  LetSwiftAPI.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Moya
import UIKit
import RxSwift

public enum LetSwiftAPI {
    case healthCheck
}

extension LetSwiftAPI: TargetType {
    public var path: String {
        switch self {
        case .healthCheck:
            return "/users"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .healthCheck:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .healthCheck:
            return .requestParameters(parameters: parameters, encoding: URLEncoding(destination: .queryString))
        }
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
}

extension LetSwiftAPI {
    public var parameters: [String: Any] {
        switch self {
        case .healthCheck:
            return [:]
        }
    }
}
