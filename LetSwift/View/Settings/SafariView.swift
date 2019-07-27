//
//  SafariView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/07/27.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let entersReaderIfAvailable: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = entersReaderIfAvailable
        let safari = SFSafariViewController(url: url, configuration: configuration)
        return safari
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
}
