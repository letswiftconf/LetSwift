//
//  NetworkManager.swift
//  LetSwift
//
//  Created by Son on 2022/11/22.
//

import Foundation
final class NetworkManager {
    static let shared = NetworkManager()
    
    struct NetworkMethod {
        public static let getQuestions = NetworkMethod(rawValue: "/question")
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        let usingProtocol = "http"
        let serverURL = "13.209.242.34:29443"
        let version = "api/v1/"
        let rawValue : String
        
        func getApiURL() -> URL {
            return URL(string: "\(usingProtocol)://\(serverURL)/\(version)\(rawValue)")!
        }
    }
    
    func getSession(api: NetworkMethod) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: api.getApiURL())
    }
//    
//    func get() {
//        getSession(api: .getQuestions)  { data, _, error in
//            if let error = error {
//                
//            } else if let data = data {
//                do {
//                    let result = try JSONDecoder().decode([ProfileAPIData].self, from: data)
//                    
//                } catch {
//                    
//                }
//            }
//        }
//    }
}
 
