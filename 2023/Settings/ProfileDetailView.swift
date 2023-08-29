//
//  ProfileDetailView.swift
//  LetSwift
//
//  Created by 이가은 on 2022/11/09.
//

import SwiftUI

struct ProfileDetailView: View {
    let imageName: String
    let name: String
    let role: ProfileRole
    let description: String
    let sns: [SNSCategory]
    init(imageName: String, name: String, role: ProfileRole, description: String, sns: [SNSCategory]) {
        self.imageName = imageName
        self.name = name
        self.role = role
        self.description = description
        self.sns = sns
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    if let image = UIImage(named: imageName) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                            .padding(.trailing, 24)
                    } else {
                        Image("tempImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                            .padding(.trailing, 24)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .foregroundColor(.orange)
                            .font(.title3Bold)
                            .padding(.top, 10)
                        Spacer()
                        Text(role.rawValue)
                            .foregroundColor(.textGray)
                            .font(.subheadRegular)
                            .padding(.bottom, 6)
                    }
                }
                Text(description)
                    .font(.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 34)
                    .padding(.bottom, 50)
                
                ForEach(sns, id: \.self) { sns in
                    switch sns {
                        case .email(let address):
                            boxText(title: sns.localizedString, text: address)
                        case .gitHub(let path), .twitter(let path), .blog(let path), .linkedIn(let path), .SNS(let path):
                            boxLink(title: sns.localizedString, link: URL(string: path) ?? URLData.homePage2022)
                    }
                }
            }
            .padding(.bottom, 200)
            .padding(.horizontal, 20)
        }
        .foregroundColor(.white)
        .padding(.vertical, 16)
        .background(Color.backgroundBlack)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("", displayMode: .inline)
    }
}

extension ProfileDetailView {
    @ViewBuilder func gradationBox() -> some View {
        Rectangle()
            .fill(LinearGradient.gradientOrange.opacity(0.45))
            .cornerRadius(10)
    }
    @ViewBuilder func boxText(title: String, text: String) -> some View {
        HStack(alignment: .bottom) {
            Text(title)
                .padding(.leading, 25)
            Spacer()
            Text(text)
                .padding(.trailing, 25)
        }
        .font(.bodyRegular)
        .padding(.vertical, 16)
        .background(gradationBox())
        .cornerRadius(10)
        .padding(.bottom, 18)
    }
    @ViewBuilder func boxLink(title: String, link: URL) -> some View {
        Link(destination: link) {
            HStack(alignment: .bottom) {
                Text(title)
                    .padding(.leading, 25)
                Spacer()
                Image(systemName: "arrow.up.forward")
                    .padding(.trailing, 25)
            }
        }
        .font(.bodyRegular)
        .padding(.vertical, 16)
        .background(gradationBox())
        .cornerRadius(10)
        .padding(.bottom, 18)
    }
}

//struct ProfileDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileDetailView()
//    }
//}
