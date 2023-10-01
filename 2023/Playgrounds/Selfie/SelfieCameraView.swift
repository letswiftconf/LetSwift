//
//  SelfieCameraView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI

struct SelfieCameraView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var currentIndex: Int = 0
    
    @StateObject var model = SelfieCameraModel()
    
    @State var frames: [SelfieEntity] = SelfieEntity.allCases
    
    var body: some View {
//        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                VStack {
                    
                    if (model.isAllow == true) {
                        
                        Text("프레임을 선택 후 카메라로 촬영하면\n인증샷을 만들어드려요!")
                            .multilineTextAlignment(.center)
                            .font(.bodyBold)
                            .padding(.top, 15)
                        
                        Spacer().frame(height: 20)
                        
                        if let pictrue = model.pictrue, model.isSaved {
                            Image(uiImage: pictrue)
                                .resizable()
                                .scaledToFit()
                        } else {
                            ZStack {
                                if let captureImage = model.captureImage {
                                    Image(uiImage: captureImage)
                                        .resizable()
                                        .scaledToFit()
                                }
                                Image(frames[currentIndex].frameImage)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        
                        Spacer().frame(height: 8)
                        
                        if (model.isTaken) {
                            completeView()
                        } else {
                            cameraView()
                        }
                    } else {
                        Text("카메라 권한이 없어요😢\n인증샷을 위해 카메라 권한을 확인해 주세요!")
                            .multilineTextAlignment(.center)
                            .font(.bodyBold)
                        
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            
                            if UIApplication.shared.canOpenURL(url) {
                                Spacer()
                                    .frame(height: 20)
                                Button {
                                    UIApplication.shared.open(url)
                                } label: {
                                    Text("설정으로 가기")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.primary_2023)
                                        .clipShape(Capsule())
                                }.padding(.leading)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    self.closeButton()
//                }
//            }
            .onAppear {
                model.check()
                model.maskingImageString = frames[currentIndex].maskingImage
            }
            .onDisappear {
                model.stop()
            }
            .onChange(of: currentIndex) { newValue in
                model.maskingImageString = frames[newValue].maskingImage
            }
        }
    }
}

extension SelfieCameraView {
    
    private func closeButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 15)
        }
    }
    
    private func completeView() -> some View {
        HStack {
            Button {
                if (!model.isSaved) {
                    self.model.save(maskingImage: UIImage.init(named: "\(frames[currentIndex].frameImage)")!)
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
                    self.currentIndex = 0
                } label: {
                    Text("다시 찍기")
                        .foregroundColor(.white)
                }.padding(.trailing, 20)
            }
        }.frame(height: 75)
    }
    
    private func cameraView() -> some View {
        ZStack {
            VStack {
                Spacer().frame(height: 15)
                
                HStack {
                    Spacer()
                    ZStack {
                        
                        SelfieFrameCarouselView(spacing: 40.0, size: 65.0, index: $currentIndex, items: frames) { frame in
                            Button {
                                self.model.takePicture()
                            } label: {
                                Image(frame.thumbImage)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 65.0, height: 65.0)
                            }
                            .frame(width: 75, height: 75)
                            .disabled(frame.id != frames[currentIndex].id)
                        }
                        
                        Circle()
                        .stroke(Color.white.opacity(0.85), style: .init(lineWidth: 2.0))
                        .frame(width: 75, height: 75)
                        
                    }.frame(height: 75)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button {
                        self.model.reverse()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }.padding(.trailing, 20)
            }
        }
    }
}
