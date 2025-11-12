//
//  SessionRowView.swift
//  LetSwift
//
//  Created by Philip Chung on 9/21/24.
//

import SwiftUI

struct SessionRowView: View {
    @Bindable private var viewModel: SessionRowViewModel

    init(viewModel: SessionRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                info
                Spacer()
                bookmarkToggle
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            Divider()
        }
    }
    
    private var info: some View {
        let s = viewModel.session
        
        return VStack(alignment: .leading, spacing: 8) {
            Text(s.title)
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.leading)
            
            HStack(spacing: 12) {
                ForEach(s.speakers, id: \.id) { speaker in
                    SessionSpeakerView(
                        name: speaker.name,
                        imageUrl: speaker.profileImage
                    )
                }
                Text(formatTimeRange(start: s.startTime, end: s.endTime))
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var bookmarkToggle: some View {
        Button { viewModel.onToggleBookmark() } label: {
            Image(systemName: viewModel.bookmarkImageString)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(viewModel.session.isSaved ? .themePrimary : .grayIcon)
        }
        .buttonStyle(.plain)
    }

    private func formatTimeRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return "\(formatter.string(from: start)) ~ \(formatter.string(from: end))"
    }
}

#Preview("Session") {
    let vm = SessionViewModel()
    SessionView()
        .environment(vm)
}


#Preview {
    SessionRowView(viewModel: SessionRowViewModel(session: SessionModel(from: Session.sampleData[0])))
        .padding(11)
}

