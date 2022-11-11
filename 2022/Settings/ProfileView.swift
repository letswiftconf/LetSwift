//
//  ProfileView.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/09.
//

import SwiftUI

struct ProfileView: View {
    @State var profileRole: ProfileRole = .supporter
    
    enum ProfileRole: String, CaseIterable {
        case supporter
        case staff
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Supporter & Staff")
                    .font(.title3Bold)
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                HStack {
                    Spacer()
                    ForEach(ProfileRole.allCases, id: \.self) { item in
                        if profileRole == item {
                            Text(item.rawValue)
                                .padding(.vertical, 6)
                                .frame(width: 100)
                                .font(.footnote)
                                .background(gradationBox())
                                .cornerRadius(5)
                                .onTapGesture {
                                    profileRole = item
                                }
                        } else {
                            VStack(alignment: .center, spacing: 0) {
                                Text(item.rawValue)
                                    .font(.footnote)
                                    .padding(.bottom, 7)
                                Rectangle()
                                    .fill(LinearGradient.gradientOrange.opacity(0.45))
                                    .frame(width: 100, height: 3)
                            }
                            .onTapGesture {
                                profileRole = item
                            }
                        }
                    }
                }
                .animation(.default, value: profileRole)
                .padding(.bottom, 18)
                if profileRole == .staff {
                    ForEach(ProfileData.staffList) { profile in
                        NavigationLink(destination: ProfileDetailView(imageName: profile.imageName, name: profile.name, role: profile.role, description: profile.description, sns: profile.sns)) {
                            profileBox(imageName: profile.imageName, name: profile.name, description: profile.description)
                        }
                    }
                } else if profileRole == .supporter {
                    ForEach(ProfileData.supporterList) { profile in
                        NavigationLink(destination: ProfileDetailView(imageName: profile.imageName, name: profile.name, role: profile.role, description: profile.description, sns: profile.sns)) {
                                profileBox(imageName: profile.imageName, name: profile.name, description: profile.description)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 200)
        }
        .foregroundColor(.white)
        .background(Color.backgroundBlack)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("", displayMode: .inline)
    }
}

extension ProfileView {
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(10)
    }
    @ViewBuilder func profileBox(imageName: String, name: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Image("tempImage")
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
                .frame(width: 90, height: 90)
                .padding(.trailing, 19)
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.bodyRegular)
                    .foregroundColor(.orange)
                    .padding(.top, 8)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(.caption2Regular)
                Spacer()
            }
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.subheadRegular)
                Spacer()
            }
        }
        .padding(.bottom, 40)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
