//
//  SelfieCameraModel.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI
import Foundation
import AVFoundation

class SelfieCameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @Published var isTaken = false
    @Published var sesstion = AVCaptureSession()
    
    @Published var input: AVCaptureDeviceInput?
    @Published var output = AVCapturePhotoOutput()
    @Published var videoOutput: AVCaptureVideoDataOutput?
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    @Published var pictrue: UIImage? = nil
    @Published var captureImage: UIImage? = nil
    
    @Binding var maskingImageString: String
    
    private var position: AVCaptureDevice.Position = .front
    
    init(maskingImageString: Binding<String> = .constant("selfie_masking_1")) {
        self._maskingImageString = maskingImageString
    }
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setup()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if (status) {
                    self.setup()
                }
            }
        case .denied:
            return
        default:
            return
        }
    }
    
    func setup() {
        do {
            self.sesstion.beginConfiguration()
            
            if let device = AVCaptureDevice.default(for: .video) {
                
                let input = try AVCaptureDeviceInput(device: device)
                
                
                if (self.sesstion.canAddInput(input)) {
                    self.sesstion.addInput(input)
                    self.input = input
                    self.position = input.device.position
                }
                
                if (self.sesstion.canAddOutput(self.output)) {
                    self.sesstion.addOutput(output)
                }
                
                let videoOutput = AVCaptureVideoDataOutput()
                
                if (self.sesstion.canAddOutput(videoOutput)) {
                    self.sesstion.addOutput(videoOutput)
                    videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInteractive))
                    self.videoOutput = videoOutput
                }
                
                self.sesstion.commitConfiguration()
                
                self.preview = AVCaptureVideoPreviewLayer(session: self.sesstion)
                self.preview.frame = UIScreen.main.bounds
                self.preview.videoGravity = .resizeAspectFill
                
                DispatchQueue.global(qos: .background).async {
                    self.sesstion.startRunning()
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // 이미지에 마스크를 적용하는 함수
    func applyMask(image: CIImage, mask: CIImage) -> UIImage? {
        let filter = CIFilter(name: "CIBlendWithAlphaMask")
        filter?.setDefaults()
        filter?.setValue(image, forKey: kCIInputImageKey)
        filter?.setValue(mask, forKey: kCIInputMaskImageKey)
        
        if let outputImage = filter?.outputImage {
            let context = CIContext(options: nil)
            // 375 * 812 / 400 * 800
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), let maskImage = UIImage(named: "\(self.maskingImageString)") else {
            return
        }
        
        let orientation = connection.videoOrientation
        
        let image = CIImage(cvPixelBuffer: pixelBuffer)
        
        var transformImage: CIImage = image
        
        if (self.position == .front) {
            switch orientation {
            case .portrait:
                transformImage = transformImage.oriented(.left)
            case .portraitUpsideDown:
                transformImage = transformImage.oriented(.right)
            case .landscapeRight:
                transformImage = transformImage.oriented(.left)
                transformImage = transformImage.oriented(.up)
            default:
                transformImage = transformImage.oriented(.right)
                transformImage = transformImage.oriented(.up)
            }
        } else {
            switch orientation {
            case .portrait:
                transformImage = transformImage.oriented(.left)
            case .portraitUpsideDown:
                transformImage = transformImage.oriented(.right)
            case .landscapeRight:
                transformImage = transformImage.oriented(.leftMirrored)
            default:
                transformImage = transformImage.oriented(.rightMirrored)
            }
            
        }
        
        transformImage = resizeCIImage(transformImage, targetSize: maskImage.size)
        
        guard var mask = CIImage(image: maskImage) else {
            return
        }
        
        mask = resizeCIImage(mask, targetSize: maskImage.size)
        
        if let maskedImage = applyMask(image: transformImage, mask: mask) {
            DispatchQueue.main.async {
                self.captureImage = maskedImage
            }
        }
    }
    
    func resizeCIImage(_ image: CIImage, targetSize: CGSize) -> CIImage {
        let scaleX = targetSize.width / image.extent.size.width
        let scaleY = targetSize.height / image.extent.size.height
        
        return image.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
    
    func takePicture() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.sesstion.stopRunning()
            }
        }
    }
    
    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.sesstion.startRunning()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                    self.pictrue = nil
                    self.isSaved = false
                }
            }
        }
    }
    
    // TODO: 전면<>후면 간 전환 시 안되는 현상 bug fix 필요
    func reverse() {
        // 현재 사용 중인 카메라를 가져오기
        guard let input = self.input else {
            return
        }
        
        // 사용 가능한 모든 비디오 카메라 장치 가져오기
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: self.position == .front ? .back : .front
        )
        let videoDevices = discoverySession.devices
        
        // 다른 카메라 찾기 (전면 카메라 <-> 후면 카메라 전환)
        for device in videoDevices {
            if device.position != self.position {
                
                do {
                    let newInput = try AVCaptureDeviceInput(device: device)
                    self.sesstion.removeInput(input)
                    
                    if self.sesstion.canAddInput(newInput) {
                        self.sesstion.addInput(newInput)
                        self.input = newInput
                        self.position = device.position
                    }
                } catch {
                    print("reverse:: error:: \(error.localizedDescription)")
                }
                
                break
            }
        }
    }
    
    func stop() {
        self.sesstion.stopRunning()
        
        DispatchQueue.main.async {
            withAnimation {
                self.isTaken = false
                self.pictrue = nil
                self.isSaved = false
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if let imageData = photo.fileDataRepresentation() {
            self.picData = imageData
            
        }
    }
    
    func save(maskingImage: UIImage) {
        guard var picture = UIImage(data: self.picData) else {
            // empty data
            return
        }
        
        if (self.position == .back) {
            UIGraphicsBeginImageContextWithOptions(picture.size, false, picture.scale)
            
            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: picture.size.width, y: 0)
            context.scaleBy(x: -1.0, y: 1.0)
            
            picture.draw(in: CGRect(origin: .zero, size: picture.size))
            
            let flippedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            picture = flippedImage
        }
        
        // composing images
        UIGraphicsBeginImageContextWithOptions(picture.size, true, 1)
        let size = picture.size
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        picture.draw(in: rect)
        maskingImage.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // save image
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
        
        self.pictrue = newImage
        self.isSaved = true
        
        print("success save to image")
    }
}
