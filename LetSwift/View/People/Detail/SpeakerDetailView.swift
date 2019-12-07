//
//  SpeakerDetailView.swift
//  LetSwift
//
//  Created by 김나용 on 2019/12/07.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct SpeakerDetailView: View {
    var person: SuperPerson
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                profileView
                descriptionView
            }
            .navigationBarTitle(Text(person.name))
        }
    }
    
    // MARK: - View components
    private var profileView: some View {
        return ZStack {
            LogoView()
                .blur(radius: 13, opaque: true)
                .frame(height: 220)
            VStack(spacing: 12) {
                ProfileImageView(imageName: person.name)
                    .frame(width: 120, height: 120)
                VStack(spacing: 4) {
                    Text(person.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(person.organization)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(person.description)
                    .font(.body)
                if !person.tags.isEmpty {
                    Text(person.joinedTags)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Divider()
            sessionView()
        }
        .padding()
    }
    
    private func sessionView() -> AnyView? {
        guard let sessions = (person as? ProtoSpeaker)?.sessions else {
            return nil
        }
        return AnyView(VStack(alignment: .leading, spacing: 8) {
            Text("Sessions")
                .font(.headline)
            ForEach(sessions, id: \.description) {
                Text($0)
                    .font(.footnote)
            }
        })
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpeakerDetailView(person: ProtoSpeaker.speakers.first!)
            SpeakerDetailView(person: ProtoSpeaker.speakers.last!)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
    }
}
