//
//  NetworkService.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Moya
import RxSwift
import Foundation

class NetworkService {
    static let shared = NetworkService()
    let plugin = NetworkActivityPlugin { (changeType, targetType) in
        
        switch changeType {
        case .began:
            if let target = targetType as? LetSwiftAPI {
                switch target {
                case .auth,.putAuth,.comment,.userComment,.putComment:
                    DispatchQueue.main.async {
                        IndicatorView.shared.show()
                    }
                }
            }
            
        case .ended:
            DispatchQueue.main.async {
                IndicatorView.shared.hide()
            }
            break
        }
        
    }
    
    lazy var provider = NetworkProvider(plugin)
    
    func request<T: Decodable>(_ target: LetSwiftAPI,
                               expectingReturnType: T.Type ) -> PrimitiveSequence<SingleTrait, Result<T, NetworkException>> {
        
        return provider.request(target)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .serverErrorHandler(expectingReturnType: expectingReturnType)
    }
    
}

public struct ErrorTranperDTO: Codable {
    public let timestamp, gid, statusCode, statusName: String
    public let path, errorMessageCode, errorMessage, errorClassName: String
    public let errorStack: [String]?
}

public enum NetworkException: Error {
    case errorStatusCode(ErrorTranperDTO)
    case errorTypeCasting
}

extension Moya.Response {
    
    public func responseResult<T: Decodable>(expectingReturnType: T.Type) -> Result<T, NetworkException>{
        switch self.statusCode {
        case 200...299:
            if expectingReturnType.self == String.self {
                return Result.success(String(decoding: data, as: UTF8.self) as! T)
            } else {
                do {
                    let model = try JSONDecoder().decode(expectingReturnType.self, from: self.data)
                    return Result.success(model)
                }
                catch {
                    return Result.failure(.errorTypeCasting)
                }
            }
        default:
            return Result.failure(.errorTypeCasting)
        }
    }
}


extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    public func serverErrorHandler<T: Decodable>(expectingReturnType: T.Type) -> Single<Result<T, NetworkException>> {
        
        return flatMap { response -> Single<Result<T, NetworkException>> in
            let result = response.responseResult(expectingReturnType: expectingReturnType)
            
            // 에러일 경우 에러 팝업처리 필요시 사용 가능
            switch result {
            case .failure(_):
                break
            default: break
            }
            
            return Single.just(result)
        }
    }
}

