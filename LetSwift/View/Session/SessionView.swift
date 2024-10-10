//
//  SessionView.swift
//  LetSwift
//
//  Created by 박진서 on 8/30/24.
//

import SwiftUI

struct SessionView: View {

    @Bindable private var viewModel: SessionViewModel
    
    init(viewModel: SessionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                tabView
                sessionList
            }
            .background(Color.darkBackground)
        }
        .task {
            defer { viewModel.update(isLoading: false) }
            viewModel.update(isLoading: true)
            guard let sessions = try? await viewModel.fetchSessions() else { return }
            viewModel.update(sessions: sessions)
        }
    }
    
    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(SessionTab.allCases) { tab in
                Button {
                    viewModel.update(currentTab: tab)
                } label: {
                    ZStack {
                        Color.darkBackground
                        Text(tab.title)
                            .font(viewModel.currentTab == tab ? .medium(size: 15) : .regular(size: 15))
                            .foregroundStyle(viewModel.currentTab == tab ? Color.primaryPink : Color.gray5)
                    }
                    .overlay(alignment: .bottom) {
                        if viewModel.currentTab == tab {
                            Color.primaryPink.frame(height: 3)
                        } else {
                            Color.gray5.frame(height: 1)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
    }
    
    private var sessionList: some View {
        ScrollView {
            VStack(spacing: 1) {
                ForEach(Array(viewModel.filteredSessions.enumerated()), id: \.offset) { offset, sessionRowViewModel in
                    SessionRowView(viewModel: sessionRowViewModel)
                        .overlay(alignment: .top) {
                            if offset != .zero {
                                Color.grayStoke
                                    .frame(height: 1)
                            }
                        }
                }
            }
        }
        .overlay {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(viewModel.isLoading ? 1.0 : 0.0)
        }
    }
}


#Preview {
    SessionView(viewModel: SessionViewModel())
}
