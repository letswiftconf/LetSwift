//
//  ShareManager.swift
//  LetSwift
//
//  Created by YeajuChoi on 2023/09/28.
//

import Foundation
import Photos
import SwiftUI
import UIKit

struct ShareManager {
    
    static func shareInstagrame(with shareImage: UIImage) {
        
        var shareURL = ""
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAsset(from: shareImage)
            let assetID = request.placeholderForCreatedAsset?.localIdentifier ?? ""
            shareURL = "instagram://library?LocalIdentifier=" + assetID
            
        }, completionHandler: {_, _ in
            DispatchQueue.main.async {
                if let urlForRedirect = URL(string: shareURL) {
                    UIApplication.shared.open(urlForRedirect as URL, options: [:], completionHandler: { success in
                        if !success {
                            Toast.shared.show(message: "인스타그램을 설치해주세요.")
                        }
                    })
                } else {
                    Toast.shared.show(message: "인스타그램을 설치해주세요.")
                }
            }
        })
    }
    
}
