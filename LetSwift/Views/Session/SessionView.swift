//
//  SessionView.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import SwiftUI

struct SessionView: View {
    @Environment(SessionViewModel.self) var viewModel
    
    var body: some View {
        VStack(spacing: 0) {
            tabView
            sessionList
        }
        .padding(.top, 20)
        .task {
            viewModel.load()
        }
    }
    
    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(SessionTab.allCases) { tab in
                Button {
                    viewModel.update(currentTab: tab)
                } label: {
                    Text(tab.title)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(viewModel.currentTab == tab ? .primary : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                        .overlay(alignment: .bottom) {
                            if viewModel.currentTab == tab {
                                Color.themePrimary.frame(height: 4)
                                    .cornerRadius(4)
                            } else {
                                Color(.opaqueSeparator).frame(height: 2)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var sessionList: some View {
        ScrollView {
            VStack(spacing: 22) {
                ForEach(Array(viewModel.filteredSessions.enumerated()), id: \.offset) { offset, sessionRowViewModel in
                    SessionRowView(viewModel: sessionRowViewModel)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 22)
        }
        .overlay {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(viewModel.isLoading ? 1.0 : 0.0)
        }
    }
}


#Preview("Light Mode") {
    let vm = SessionViewModel()
    SessionView()
        .environment(vm)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let vm = SessionViewModel()
    SessionView()
        .environment(vm)
        .preferredColorScheme(.dark)
}
