//
//  CheeringCardModel.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/16.
//

import Foundation
import SwiftUI

struct CheeringCardModel: Codable{
    var name: String
    var category: String
    var image: Data?
    
    func getImage(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    /*
     Image 적용하기
     guard let data = user.image else {
         return
     }
     
     let image = UIImage(data: data)
     */
}
