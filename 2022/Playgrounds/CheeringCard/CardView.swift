//
//  CardView.swift
//  LetSwift
//
//  Created by jiin heo on 2022/11/08.
//

import SwiftUI



struct CardView: View {
    
    // TODO: Loading(Lottie), 이미지 저장, 공유 기능
    // TODO: 다시뽑기
    
    // TODO: category 계산 로직 추가
    // TODO: userData 가져오기 추가
    
    @Environment(\.presentationMode) var presentationMode
    @State var isShowAlert = false
    
    let category = TempChartData.getCardCase(answerId: 1)
    let name = "허지인"
    
    var body: some View {
        VStack {
            captureView
                .foregroundColor(.white)
            Text("#letswift #렛츠스위프트 @letswift를 태그해서 \n이미지를 공유하면 추첨해서 굿즈를 드립니다. ")
                .font(.subheadRegular)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            NavigationLink {
                ChartView()
            } label: {
                HStack {
                    Spacer()
                    Text("참가자 전체 결과 보기")
                        .font(.title3Reqular)
                        .foregroundColor(.white)
                    Spacer()
                }
                
            }
            .padding(10)
            .background(gradationBox())
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.top, 10)
            
            HStack {
                Button {
                    let image = captureView
                        .foregroundColor(.black).snapshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    isShowAlert = true
                } label: {
                    boxText(title: "이미지 저장", image: "arrow.down.to.line")
                }
                Spacer()
                Button {
                    // action
                } label: {
                    boxText(title: "카드 공유", image: "square.and.arrow.up")
                }
                Spacer()
                Button {
                    // action
                } label: {
                    boxText(title: "동료 찾기", image: "magnifyingglass")
                }
            }
            .padding(.top, 10)
            //TODO: Add Retry Button
            Button {
                print("다시 뽑기 click")
            } label: {
                Spacer()
                HStack {
                    Image(systemName: "goforward")
                        .foregroundColor(.textGray)
                        .frame(width: 10, height: 10)
                    Text("다시 뽑기")
                        .font(.footnote)
                        .foregroundColor(.textGray)
                }
                .padding(.top,10)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundBlack)
        .navigationTitle("")
        .toolbar {
            // TODO: Close dismiss 구현
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
        .alert(isPresented: $isShowAlert) {
            return Alert(title: Text("사진이 저장되었습니다!"), message: nil, dismissButton: .cancel(Text("확인")))
        }
    }
}


extension CardView {
    var captureView: some View {
        VStack {
            Image("CheeringCard")
                .resizable()
                .scaledToFit()
            HStack {
                // TODO: 밑줄 구현
                Text("\(category.rawValue) \(name)님! \n Playground에서 함께 놀아요")
                    .font(.title3Bold)
                    .bold()
                    .padding(.leading, 10)
                    .padding(.top, 10)
                Spacer()
            }
        }
    }
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 4, y: 4)
    }
    
    @ViewBuilder func boxText(title: String, image: String) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Image(systemName: image)
                .frame(width: 10, height: 10)
                .foregroundColor(.white)
            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
                .cornerRadius(3)
            Spacer()
        }
        .frame(height: 35)
        .background(Color.backgroundCell)
        .cornerRadius(5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
