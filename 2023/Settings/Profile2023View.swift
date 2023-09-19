//
//  Profile2023View.swift
//  LetSwift
//
//  Created by Hani on 2023/09/20.
//

import SwiftUI

struct Profile2023View: View {
    private let profile: Profile2023
    
    init(profile: Profile2023) {
        self.profile = profile
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(profile.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(Circle())
                .padding(.horizontal, 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(profile.name)
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                HStack {
                    Text(profile.role.rawValue)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(hex: 0x82B7FA, alpha: 1))
                    Spacer()
                    
                    if let sns = profile.sns {
                        Link(destination: URL(string: sns)!) {
                            Image(systemName: "arrow.up.right")
                                .foregroundStyle(.white)
                        }
    
                    
                    }
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.white)
            }
            .padding(.horizontal)
            
            Text(profile.description)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.white)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.horizontal, 10)
        .background(Color.backgroundBlack)
        .toolbar(.hidden, for: .tabBar)
    }
}

