//
//  EventsView.swift
//  LetSwift
//
//  Created by BumMo Koo on 7/13/24.
//

import SwiftUI


struct EventsView: View {
    
    // MARK: - Properties
    @State private var payload: String = ""
    @State private var eventCellStates: [Event] = Event.allCases
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 0), count: StampBoard.boardRowCount)
    }
    
    // MARK: - Views
    var body: some View {
        VStack(spacing: 0) {
            header()
            content()
            
            Spacer(minLength: 0)
            
            footer()
        }
        .padding(.horizontal, 20)
        .background(.darkBackground)
    }
}

// MARK: - Body
fileprivate extension EventsView {
    @ViewBuilder
    func header() -> some View {
        VStack(spacing: 12) {
            Text("eventHeader.title")
                .foregroundStyle(.whiteText)
                .font(.bold(size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("eventHeader.description")
                .foregroundStyle(.gray9)
                .font(.regular(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineSpacing(3)
        }
        .padding(.top, 44)
        .padding(.bottom, 23)
    }
    
    @ViewBuilder
    func content() -> some View {
        companyEvents()
    }
    
    @ViewBuilder
    func footer() -> some View {
        StampButton(payload: $payload)
            .frame(height: 50)
            .padding(.bottom, 14)
    }
}

// MARK: - Content
fileprivate extension EventsView {
    @ViewBuilder
    func companyEvents() -> some View {
        LazyVGrid(columns: gridLayout, spacing: 0) {
            ForEach(Array(StampImagePosition.positions.enumerated()), id: \.offset) { (index, position) in
                eventCell(at: index)
                    .overlay {
                        if index < eventCellStates.count {
                            Image(uiImage: eventCellStates[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: position.imageWidth)
                                .offset(x: position.x, y: position.y)
                                .rotationEffect(position.rotation)
                        }
                    }
            }
        }
        .background(border())
        .onChange(of: payload, { oldValue, newValue in
            guard let event = Event(rawValue: newValue) else { return }
            if !eventCellStates.contains(where: { $0.payload == event.payload }) {
                eventCellStates.append(event)
            }
        })
    }
    
    func eventCell(at index: Int) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundStyle(.clear)
            .frame(height: StampBoard.boardHeight)
            .overlay(alignment: .trailing) {
                if (index+1) % gridLayout.count != 0 {
                    VLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .frame(width: 1)
                        .foregroundStyle(.gray5)
                }
            }
            .overlay(alignment: .bottom) {
                if !isLastRow(at: index) {
                    HLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .frame(height: 1)
                        .foregroundStyle(.gray5)
                }
            }
    }
    
    func border() -> some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(style: StrokeStyle(dash: [2]))
            .foregroundStyle(.gray5)
    }
    
    private func totalRows() -> Int {
        (StampImagePosition.positions.count + gridLayout.count - 1) / gridLayout.count
    }
    
    private func isLastRow(at index: Int) -> Bool {
        let currentRow = index / gridLayout.count
        return currentRow == totalRows() - 1
    }
    
    struct VLine: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
            }
        }
    }
    
    struct HLine: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
            }
        }
    }
}


#Preview("Event(ko)") {
    TabView {
        EventsView()
            .environment(\.locale, Locale(identifier: "ko"))
    }
}

#Preview("Event(en)") {
    TabView {
        EventsView()
            .environment(\.locale, Locale(identifier: "en"))
    }
}
