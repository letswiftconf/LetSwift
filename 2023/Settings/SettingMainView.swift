//
//  SettingMainView.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/09.
//

import SwiftUI

struct SettingMainView: View {
    @State private var isSettingViewPresented = false
    
    @State var selectedRole: Profile2023.Role = .Speaker
    @State var profileList: [Profile2023] = Profile2023.speakers
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Speakers & Organizers")
                    .font(.title3Bold)
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                Spacer()
//                Button(action: {
//                    withAnimation {
//                        isSettingViewPresented.toggle()
//                    }
//                }) {
//                    Image(systemName: "gear.badge.checkmark")
//                        .fullScreenCover(isPresented: $isSettingViewPresented) {
//                            SettingView()
//                        }
//                }
            }
            .padding(.horizontal, 20)
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        ForEach(Profile2023.Role.allCases, id: \.self) { item in
                            if selectedRole == item {
                                Text(item.rawValue)
                                    .padding(.vertical, 6)
                                    .frame(width: 100)
                                    .font(.footnote)
                                    .background(Color(hex: 0x0047FF, alpha: 1))
                                    .cornerRadius(5)
                                    .padding(.bottom, 3)
                                    .onTapGesture {
                                        selectedRole = item
                                    }
                            } else {
                                VStack(alignment: .center, spacing: 0) {
                                    Text(item.rawValue)
                                        .font(.footnote)
                                        .padding(.bottom, 7)
                                    Rectangle()
                                        .fill(Color(hex: 0x0047FF, alpha: 1))
                                        .frame(width: 100, height: 3)
                                }
                                .onTapGesture {
                                    selectedRole = item
                                    switch selectedRole {
                                    case .Speaker:
                                        profileList = Profile2023.speakers
                                    case .Organizer:
                                        profileList = Profile2023.organizers
                                    }
                                }
                            }
                        }
                    }
                    .animation(.default, value: selectedRole)
                    .padding(.bottom, 18)
                    
                    LazyVGrid(
                        columns:
                            Array(
                                repeating: .init(.flexible(), spacing: 10),
                                count: 3
                            ),
                        alignment: .center,
                        spacing: 70
                    ) {
                        ForEach(profileList, id: \.id) { profile in
                            NavigationLink(
                                destination: {
                                    Profile2023View(profile: profile)
                                },
                                label: {
                                    VStack(alignment: .center) {
                                        Image(profile.imageName)
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .background(Color.yellow)
                                            .clipShape(Circle())
                                        Spacer(minLength: 10)
                                        Text(profile.name)
                                            .font(.system(size: 14, weight: .bold))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(4)

                                }
                            )
                            
                        }
                        .navigationBarTitle("", displayMode: .inline)
                        .accentColor(.white)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
            .scrollIndicators(.hidden)
        }
        .foregroundColor(.white)
        .background(Color.backgroundBlack)
        .edgesIgnoringSafeArea(.bottom)
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
