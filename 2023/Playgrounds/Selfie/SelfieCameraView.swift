//
//  SelfieCameraView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI

struct SelfieCameraView: View {
    
    @State var entity: SelfieEntity
    @State var maskingImage: UIImage?
    
    @StateObject var model = SelfieCameraModel()
    
    init(entity: SelfieEntity) {
        self.entity = entity
    }
    
    var body: some View {
        VStack {
            
            if let pictrue = model.pictrue, model.isSaved {
                Image(uiImage: pictrue)
                    .resizable()
                    .scaledToFit()
            } else {
                ZStack {
//                    SelfieCameraPreview(camera: self.model)
                    if let test = model.captureImage {
                        Image(entity.frameImage)
                            .resizable()
                            .scaledToFit()
                        Image(uiImage: test)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                
            }
            
            HStack {
                if (model.isTaken) {
                    Button {
                        if (!model.isSaved) {
                            self.model.save(maskingImage: UIImage.init(named: "\(self.entity.frameImage)")!)
                        }
                    } label: {
                        Text(self.model.isSaved ? "저장 완료!" : "저장")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(self.model.isSaved ? Color.yellow : Color.white)
                            .clipShape(Capsule())
                    }.padding(.leading)
                    
                    Spacer()
                    
                    if (model.isTaken) {
                        Button {
                            self.model.reTake()
                        } label: {
                            Text("다시 찍기")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                        }.padding(.trailing, 10)
                    }
                } else {
                    Button {
                        self.model.takePicture()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 65, height: 65)
                            Circle()
                                .stroke(Color.white, style: .init(lineWidth: 2.0))
                                .frame(width: 75, height: 75)
                        }
                    }
                    // TODO: 카메라 전면 <> 후면 layout
                        Button {
                            self.model.reverse()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }.padding(.trailing, 10)
                    
                }
            }.frame(height: 75)
        }
        .onAppear {
            model.check()
            self.maskingImage = UIImage(named: "selfie_masking")
        }
        .onDisappear {
            model.stop()
        }
    }
}
