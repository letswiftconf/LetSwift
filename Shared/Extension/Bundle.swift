//
//  Bundle.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/28.
//

import Foundation

extension  Bundle {
    func loadJSON<T: Decodable>(fileName: String) -> T {
        let data: Data
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Couldn't find \(fileName) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
        }
    }
}
