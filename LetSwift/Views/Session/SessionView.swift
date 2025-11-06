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
            liveActivityToggle
            sessionList
        }
        .padding(.top, 20)
        .task {
            viewModel.load()
        }
        .alert("알림", isPresented: Binding(
            get: { viewModel.showPermissionAlert },
            set: { if !$0 { viewModel.dismissPermissionAlert() } }
        )) {
            Button("확인") {
                viewModel.openSettings()
            }
            Button("취소", role: .cancel) {
                viewModel.dismissPermissionAlert()
            }
        } message: {
            Text("실시간 현황 알림을 받으려면 푸시 알림 권한 동의가 필요해요")
        }
        .alert("라이브 액티비티 시작", isPresented: Binding(
            get: { viewModel.showSuccessAlert },
            set: { if !$0 { viewModel.dismissSuccessAlert() } }
        )) {
            Button("확인", role: .cancel) {
                viewModel.dismissSuccessAlert()
            }
        } message: {
            Text("라이브 액티비티가 시작됩니다!")
        }
        .alert("오류", isPresented: Binding(
            get: { viewModel.showErrorAlert },
            set: { if !$0 { viewModel.dismissErrorAlert() } }
        )) {
            Button("확인", role: .cancel) {
                viewModel.dismissErrorAlert()
            }
        } message: {
            Text("인터넷 상태를 체크해주세요!")
        }
    }
    
    private var tabView: some View {
        HStack(spacing: 0) {
            ForEach(SessionTab.allCases) { tab in
                Button {
                    viewModel.update(currentTab: tab)
                } label: {
                    Text(tab.title)
                        .font(.system(size: 20, weight: .regular))
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

    private var liveActivityToggle: some View {
        HStack {
            Label("Live Activity 시작", systemImage: "bell.badge.fill")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.primary)

            Spacer()

            Button {
                Task {
                    await viewModel.startLiveActivityAction()
                }
            } label: {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(.themePrimary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .overlay(alignment: .bottom) {
            Color(.opaqueSeparator).frame(height: 1)
        }
    }

    private var sessionList: some View {
        Group {
            if viewModel.currentTab == .savedSession && viewModel.filteredSessions.isEmpty && !viewModel.isLoading {
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.secondary)

                    Text("세션을 저장하고 시작 알림을 받아보세요")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
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
