//
//  SettingMainView.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/09.
//

import SwiftUI

struct SettingMainView: View {
    @State private var isSettingViewPresented = false
    
    private let colors: [Color] = [.red, .blue, .green, .yellow, .purple]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    Text("Speakers")
                        .font(Font.system(size: 24, weight: .bold))
                        .foregroundLinearGradient(
                            colors: [.init(hex: 0x0047FF), .init(hex: 0x011F6B)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
#warning("hani, 이미지 및 네비게이션")
                            ForEach(colors.indices) { index in
                                VStack(alignment: .leading) {
                                    colors[index]
                                        .frame(width: UIScreen.main.bounds.size.width * 0.4, height: UIScreen.main.bounds.size.width * 0.4)
                                    
                                    Text("Name")
                                        .font(Font.system(size: 14, weight: .bold))
                                    
                                    Text("Title Time")
                                        .font(Font.system(size: 12, weight: .semibold))
                                }
                                .background(
                                    LinearGradient(
                                        colors: [.init(hex: 0x0047FF), .init(hex: 0x011F6B)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(20.0)
                            }
                            .frame(width: UIScreen.main.bounds.size.width * 0.4, height: UIScreen.main.bounds.size.width * 0.6)
                            
                        }
                    }
                    .onAppear {
                        UIScrollView.appearance().isPagingEnabled = true
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    Text("Organizers")
                        .font(Font.system(size: 24, weight: .bold))
                        .foregroundLinearGradient(
                            colors: [.init(hex: 0x0047FF), .init(hex: 0x011F6B)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    LazyVGrid(
                        columns:
                            Array(
                                repeating: .init(.flexible(), spacing: 10),
                                count: 3
                            ),
                        alignment: .center,
                        spacing: 10
                    ) {
                        ForEach(0..<20, id: \.self) { _ in
#warning("hani, 이미지 및 네비게이션")
                            VStack(alignment: .center) {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(Color.yellow)
                                    .clipShape(Circle())
                                Text("이름")
                                    .font(.system(size: 14, weight: .bold))
                            }
                            .padding(4)
                        }
                    }
                }
                .background(Color.backgroundBlack)
                .padding(8)
            }
            .background(Color.backgroundBlack)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isSettingViewPresented.toggle()
                        }
                    }) {
                        Image(systemName: "gear.badge.checkmark")
                            .fullScreenCover(isPresented: $isSettingViewPresented) {
                                SettingView()
                            }
                    }
                }
            }
        }
    }
}

struct SettingMainView_Previews: PreviewProvider {
    static var previews: some View {
        SettingMainView()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
extension Text {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {

            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self

            )
        }
    }
}
