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
    case putComment(id: Int)
    
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
        case let .putComment(id):
            return "/api/v1/comment/\(id)"
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
        case .auth,.putAuth,.comment,.putComment , .userComment:
            return .requestParameters(parameters: parameters, encoding: URLEncoding(destination: .queryString))
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
        case .putComment(id: let id):
            return [ "id" : id ]
        case .userComment(id: let id):
            return [ "id" : id ]
        }
    }
}
