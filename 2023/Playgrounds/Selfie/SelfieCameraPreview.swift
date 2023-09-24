//
//  SelfieCameraPreview.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI
import AVFoundation

struct SelfieCameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: SelfieCameraModel
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        let preview = AVCaptureVideoPreviewLayer.init(session: camera.sesstion)
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(preview)
        
        DispatchQueue.global(qos: .background).async {
            camera.sesstion.startRunning()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
