//
//  SafariViewController.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/07/27.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariViewController: UIViewControllerRepresentable {
    let url: URL
    let entersReaderIfAvailable: Bool
    
    // MARK: - Representable
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewController>) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = entersReaderIfAvailable
        let safari = SFSafariViewController(url: url, configuration: configuration)
        safari.preferredControlTintColor =  UIColor.themePrimary
        return safari
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewController>) {
        
    }
}

// MARK: - Preview
struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "http://letswift.kr/")!
        return Group {
            SafariViewController(url: url, entersReaderIfAvailable: false)
            SafariViewController(url: url, entersReaderIfAvailable: false)
                .environment(\.colorScheme, .dark)
            SafariViewController(url: url, entersReaderIfAvailable: false)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
