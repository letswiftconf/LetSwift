//
//  NetworkManager.swift
//  LetSwift
//
//  Created by Son on 2022/11/22.
//

import Foundation
import Combine

final class NetworkManager {
    static let shared = NetworkManager()
    
    struct NetworkMethod {
        public static let getQuestions = NetworkMethod(rawValue: "/question/list")
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        let usingProtocol = "http"
        let serverURL = "13.209.242.34:29443"
        let version = "api/v1"
        let rawValue : String
        
        func getApiURL() -> URL {
            return URL(string: "\(usingProtocol)://\(serverURL)/\(version)\(rawValue)")!
        }
    }
    
    func call<T: Decodable>(api: NetworkMethod, type: T.Type)  -> Future<T?, Never> {
        return Future<T?, Never> { promise in
            URLSession.shared.dataTask(with: api.getApiURL()) { data, _, error in
                if let error = error {
                    print(error)
                    return promise(.success(nil))
                } else if let data = data {
                    do {
                        
                        let result = try JSONDecoder().decode(T.self, from: data)
                        return promise(.success(result))
                    } catch {
                        print(error)
                        return promise(.success(nil))
                    }
                }
            }.resume()
        }
    }
}
 
