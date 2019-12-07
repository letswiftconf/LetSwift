//
//  StaffDetailView.swift
//  LetSwift
//
//  Created by 김나용 on 2019/12/07.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct StaffDetailView: View {
    
    var person: SuperPerson
    
    var body: some View {
        ZStack {
            LogoView()
                .blur(radius: 13, opaque: true)
            Rectangle()
                .foregroundColor(Color(.tertiarySystemFill))
            VStack(alignment: .center, spacing: 12) {
                profileView
                descriptionView
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - View components
    private var profileView: some View {
        Group {
            ProfileImageView(imageName: person.name)
                .frame(width: 160, height: 160)
            VStack(spacing: 4) {
                Text(person.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(person.organization)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
            .shadow(color: .white, radius: 33, x: 0, y: 0)
        }
    }
    
    private var descriptionView: some View {
        Group {
            Text(person.description)
                .font(.body)
                .fontWeight(.semibold)
                .frame(width: 320)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .shadow(color: .white, radius: 33, x: 0, y: 0)
            if !person.tags.isEmpty {
                HStack {
                    Text(person.joinedTags)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.tertiaryLabel))
                        .shadow(color: .white, radius: 33, x: 0, y: 0)
                }
            }
        }
    }
}

struct StaffDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StaffDetailView(person: ProtoStaff.makeProtoData().first!)
            StaffDetailView(person: ProtoStaff.makeProtoData().last!)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
    }
}
