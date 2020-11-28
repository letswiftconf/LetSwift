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
    func makeUIViewController(context: Context) -> QLPreviewController {
        let preview = QLPreviewController()
        preview.dataSource = context.coordinator
        return preview
    }
    
    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        
    }
    
    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(assetName: assetName)
    }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        private let assetName:String
        
        // MARK: - Initialization
        init(assetName: String) {
            self.assetName = assetName
        }
        
        // MARK: - Quick look
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            guard let fileURL = Bundle.main.url(forResource: assetName,
                                                withExtension: "reality") else {
                fatalError()
            }
            return fileURL as QLPreviewItem
        }
    }
}

// MARK: - Preview
struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView(assetName: "2011_apple_event")
            .previewAsScreen()
    }
}
