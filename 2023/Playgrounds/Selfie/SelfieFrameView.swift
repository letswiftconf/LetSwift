//
//  SelfieFrameView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/24.
//

import SwiftUI

// 인증샷 프레임 선택 뷰
struct SelfieFrameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 32) {
                    selfieFrameButton(type: .typeA)
                        .frame(maxWidth: .infinity)
                    selfieFrameButton(type: .typeB)
                        .frame(maxWidth: .infinity)
                }.padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundBlack)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    self.closeButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("프레임 선택")
                        .font(.title3Bold)
                }
            }
        }
        
    }
}

// components
extension SelfieFrameView {
    private func closeButton() -> some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 15)
        }
    }
    
    private func selfieFrameButton(type: SelfieFrameType) -> some View {
        
        let entity = SelfieEntity(type: type)
        
        return Button {
            print("카메라 찍으러 가자:: \(entity.type)")
        } label: {
            Image(entity.frameImage)
                .resizable()
                .scaledToFit()
        }
        .shadow(color: .white.opacity(0.2), radius: 5, x: 4, y: 4)
    }
}

struct SelfieFrameView_Previews: PreviewProvider {
    static var previews: some View {
        SelfieFrameView()
    }
}
