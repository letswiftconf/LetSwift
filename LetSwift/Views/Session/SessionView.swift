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
        VStack(spacing: 0) {
            tabView
            sessionList
        }
        .task {
            viewModel.initialize()
        }
    }
    
    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(SessionTab.allCases) { tab in
                Button {
                    viewModel.update(currentTab: tab)
                } label: {
                    ZStack {
                        Color(.systemBackground)
                        Text(tab.title)
                            .font(viewModel.currentTab == tab ? .system(size: 15, weight: .medium) : .system(size: 15))
                            .foregroundStyle(viewModel.currentTab == tab ? Color.themePrimary : Color.primary)
                    }
                    .overlay(alignment: .bottom) {
                        if viewModel.currentTab == tab {
                            Color.themePrimary.frame(height: 3)
                        } else {
                            Color(.opaqueSeparator).frame(height: 1)
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
                                Color(.separator)
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
