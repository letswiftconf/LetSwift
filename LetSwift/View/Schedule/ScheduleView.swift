//
//  ScheduleView.swift
//  LetSwift
//
//  Created by BumMo Koo on 27/07/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    @State var selectedIndex = 0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedIndex) {
                    Text("세션")
                        .tag(0)
                    Text("티타임")
                        .tag(1)
                    Text("워크샵")
                        .tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                HStack {
                    List {
                        containerView
                    }
                }
            }
            .navigationBarTitle("일정")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var containerView: AnyView {
        switch selectedIndex {
        case 0:
            return
                AnyView(
                    
                    ForEach(ProtoSession.sessions) { session in
//                        NavigationLink(destination: SessionView(session: session)) {
                            HStack(alignment: .top) {
                                ZStack {
                                    Circle()
                                        .fill(Color(.themePrimary))
                                        .frame(width: 30, height: 30)
                                    Text(session.level)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                VStack(alignment: .leading) {
                                    Text(session.title)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                    Text(session.speaker)
                                        .font(.subheadline)
                                        .foregroundColor(Color(.secondaryLabel))
                                    Text(session.time)
                                        .font(.caption)
                                        .foregroundColor(Color(.tertiaryLabel))
                                        .multilineTextAlignment(.leading)
                                }
                                
                            }
//                        }
                    }
            )
        case 1:
            return AnyView(
                
                ForEach(ProtoSession.teatime) { session in
//                    NavigationLink(destination: SessionView(session: session)) {
                        HStack(alignment: .top) {
                            ZStack {
                                Circle()
                                    .fill(Color(.themePrimary))
                                    .frame(width: 30, height: 30)
                                Text(session.level)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading) {
                                Text(session.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                Text(session.speaker)
                                    .font(.subheadline)
                                    .foregroundColor(Color(.secondaryLabel))
                                Text(session.time)
                                    .font(.caption)
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .multilineTextAlignment(.leading)
                            }
                            
                        }
                    }
//                }
            )
        case 2:
            return AnyView(
                
                ForEach(ProtoSession.workshop) { session in
//                    NavigationLink(destination: SessionView(session: session)) {
                        HStack(alignment: .top) {
                            ZStack {
                                Circle()
                                    .fill(Color(.themePrimary))
                                    .frame(width: 30, height: 30)
                                Text(session.level)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading) {
                                Text(session.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                Text(session.speaker)
                                    .font(.subheadline)
                                    .foregroundColor(Color(.secondaryLabel))
                                Text(session.time)
                                    .font(.caption)
                                    .foregroundColor(Color(.tertiaryLabel))
                                    .multilineTextAlignment(.leading)
                            }
                            
//                        }
                    }
                }
            )
        default:
            return AnyView(EmptyView())
        }
    }
}

// MARK: - Preview
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScheduleView()
            ScheduleView()
                .environment(\.colorScheme, .dark)
            ScheduleView()
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
