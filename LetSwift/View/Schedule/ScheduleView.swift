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
                    Text("Track A")
                        .tag(0)
                    Text("Track B")
                        .tag(1)
                    Text("Track C")
                    .tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                List {
                    ForEach(1...20, id: \.self) { _ in
                        NavigationLink(destination: EmptyView()) {
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color(.secondarySystemBackground))
                                    .frame(width: 60, height: 60)
                                VStack(alignment: .leading) {
                                    Text("Title")
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                    Text("Speaker")
                                        .font(.subheadline)
                                        .foregroundColor(Color(.secondaryLabel))
                                    Text("Vestibulum id ligula porta felis euismod semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mattis consectetur purus sit amet fermentum.")
                                        .font(.caption)
                                        .foregroundColor(Color(.tertiaryLabel))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Schedule")
        }
    }
}

// MARK: - Preview
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
