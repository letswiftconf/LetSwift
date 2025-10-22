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
        HStack {
            VStack(spacing: 3) {
                Color(.opaqueSeparator)
                    .frame(width: 1)
                
                Circle()
                    .stroke(Color(.opaqueSeparator))
                    .frame(width: 10, height: 10)
                
                Color(.opaqueSeparator)
                    .frame(width: 1)
            }
            .padding(.leading, 29)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(LocalizedStringKey(viewModel.session.title))
                    .font(.system(size: 15, weight: .medium))
                HStack {
                    ForEach(viewModel.session.speaker) { speaker in
                        SessionSpeakerView(name: speaker.name, imageUrl: speaker.profileImage)
                    }
                    
                    if viewModel.session.speaker.count > 0 {
                        Text(String("."))
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                    }
                    
                    Text(formatTimeRange(start: viewModel.session.startTime, end: viewModel.session.endTime))
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: viewModel.onToggleBookmark) {
                    Image(systemName: viewModel.bookmarkImageString)
                        .tint(viewModel.session.isSaved ? .themePrimary : .secondary)
                }
                
                Button(action: {
                    Task {
                        await viewModel.onToggleAlarm()
                    }
                }) {
                    Image(systemName: viewModel.alarmImageString)
                        .tint(viewModel.session.isAlarmed ? .themePrimary : .secondary)
                }
            }
            .frame(width: 24, height: 24)
            .padding(.trailing, 16)
        }
        .frame(height: 120)
        .customAlert($viewModel.alert)
    }

    private func formatTimeRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return "\(formatter.string(from: start)) ~ \(formatter.string(from: end))"
    }
}

#Preview("Session") {
    SessionView(viewModel: SessionViewModel())
}


#Preview {
    SessionRowView(viewModel: SessionRowViewModel(session: SessionModel(from: Session.sampleData[0])))
}
