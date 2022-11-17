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
    case auth
    case putAuth
    case comment
    case userComment(id: Int)
    case putComment(contents: String, userId: Int)
    
}

extension LetSwiftAPI: TargetType {
    public var path: String {
        switch self {
        case .auth:
            return "/api/v1/auth/"
        case .putAuth:
            return "/api/v1/auth/"
        case .comment:
            return "/api/v1/comment"
        case let .userComment(id):
            return "/api/v1/comment/\(id)"
        case .putComment:
            return "/api/v1/comment"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .auth, .comment, .userComment:
            return .get
        case .putAuth, .putComment:
            return .put
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .auth,.putAuth,.comment, .userComment:
            return .requestParameters(parameters: parameters, encoding: URLEncoding(destination: .queryString))
        case .putComment:
            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return [ "Content-Type" : "application/json" ]
    }
    
    public var baseURL: URL {
        return URL(string: "http://13.209.242.34:29443")!
    }
}

extension LetSwiftAPI {
    public var parameters: [String: Any] {
        switch self {
        case .auth :
            return [:]
        case .putAuth:
            return [:]
        case .comment:
            return [:]
        case let .putComment(contents, userId):
            return [
                "contents" : contents,
                "userId" : userId
            ]
        case .userComment(id: let id):
            return [ "id" : id ]
        }
    }
}
