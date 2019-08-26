//
//  String.swift
//  LetSwift Data Manager
//
//  Created by HyungJung Kim on 26/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import UIKit


extension String {
    
    internal var isValidURL: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(url)
    }
    
}
