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
                Color.gray5
                    .frame(width: 1)
                
                Circle()
                    .stroke(Color.gray5)
                    .frame(width: 10, height: 10)
                
                Color.gray5
                    .frame(width: 1)
            }
            .padding(.leading, 29)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(LocalizedStringKey(viewModel.session.name))
                    .font(.medium(size: 15))
                    .foregroundStyle(.whiteText)
                HStack {
                    if let speaker = viewModel.session.speaker {
                        AsyncImage(url: URL(string: speaker.imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        
                        Text(LocalizedStringKey(speaker.name))
                            .font(.regular(size: 12))
                            .foregroundColor(.gray8)
                        
                        Text("·")
                            .font(.regular(size: 12))
                            .foregroundColor(.gray8)
                    }
                    
                    Text(formatTimeRange(start: viewModel.session.startTime, end: viewModel.session.endTime))
                        .font(.regular(size: 12))
                        .foregroundColor(.gray8)
                }
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: viewModel.onToggleBookmark) {
                    Image(viewModel.bookmarkImageString)
                }
                
                Button(action: {
                    Task {
                        await viewModel.onToggleAlarm()
                    }
                }) {
                    Image(viewModel.alarmImageString)
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


#Preview {
    SessionRowView(viewModel: SessionRowViewModel(session: SessionModel(from: Session.sampleData[0])))
}
