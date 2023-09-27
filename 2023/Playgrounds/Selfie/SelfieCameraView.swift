//
//  SelfieCameraView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI

struct SelfieCameraView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var entity: SelfieEntity
    @State var maskingImage: UIImage?
    
    @StateObject var model = SelfieCameraModel()
    
    var body: some View {
        ZStack {
            Color.backgroundBlack.ignoresSafeArea(.all)
            VStack {
                Spacer().frame(height: 20)
                
                if let pictrue = model.pictrue, model.isSaved {
                    Image(uiImage: pictrue)
                        .resizable()
                        .scaledToFit()
                } else {
                    ZStack {
                        Image(entity.frameImage)
                            .resizable()
                            .scaledToFit()
                        if let captureImage = model.captureImage {
                            Image(uiImage: captureImage)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Spacer().frame(height: 8)
                
                if (model.isTaken) {
                    one()
                } else {
                    two()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                self.closeButton()
            }
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

extension SelfieCameraView {
    
    private func closeButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
        }
    }
    
    private func one() -> some View {
        HStack {
            Button {
                if (!model.isSaved) {
                    self.model.save(maskingImage: UIImage.init(named: "\(self.entity.frameImage)")!)
                }
            } label: {
                Text(self.model.isSaved ? "저장 완료!" : "저장")
                    .foregroundColor(self.model.isSaved ? .white : .black)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(self.model.isSaved ? Color.primary_2023 : Color.white)
                    .clipShape(Capsule())
            }.padding(.leading)
            
            Spacer()
            
            if (model.isTaken) {
                Button {
                    self.model.reTake()
                } label: {
                    Text("다시 찍기")
                        .foregroundColor(.white )
                }.padding(.trailing, 20)
            }
        }.frame(height: 75)
    }
    
    private func two() -> some View {
        ZStack {
            HStack {
                Spacer()
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
                Spacer()
            }
            
            HStack {
                Spacer()
                Button {
                    self.model.reverse()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }.padding(.trailing, 20)
        }
    }
}
