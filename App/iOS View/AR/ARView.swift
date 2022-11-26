//
//  ARView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/22.
//

import SwiftUI
import QuickLook

struct ARView: UIViewControllerRepresentable {
    let assetName: String
    
    // MARK: - Representable
    func makeUIViewController(context: Context) -> UINavigationController {
        let preview = QLPreviewController()
        let navigation = UINavigationController(rootViewController: preview)
        preview.delegate = context.coordinator
        preview.dataSource = context.coordinator
        return navigation
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if let preview = uiViewController.topViewController as? QLPreviewController {
            preview.reloadData()
        }
    }
    
    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(assetName: assetName)
    }
    
    class Coordinator: NSObject, QLPreviewControllerDelegate, QLPreviewControllerDataSource, UINavigationControllerDelegate {
        private let assetName:String
        
        // MARK: - Initialization
        init(assetName: String) {
            self.assetName = assetName
        }
        
        // MARK: - Quick look
        // Data source
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            guard let fileURL = Bundle.main.url(forResource: assetName,
                                                withExtension: "usdz") else {
                fatalError()
            }
            return fileURL as QLPreviewItem
        }
    }
}

// MARK: - Preview
struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView(assetName: "let")
            .previewAsScreen()
    }
}
