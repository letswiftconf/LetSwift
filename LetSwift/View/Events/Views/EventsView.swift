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
    @State private var companyCellStates = Array(repeating: false, count: Company.allCases.count)
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 5)
    }
    
    // MARK: - Views
    var body: some View {
        VStack {
            ScrollView {
                header()
                
                content()
            }
            .padding(.horizontal, 20)
            
            footer()
        }
        .background(.darkBackground)
        .tabItem {
            Label("events.title", image: "ic_event")
        }
        .toolbarBackground(.darkBackground, for: .tabBar)
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
                .foregroundStyle(.gray8)
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
            .padding(.horizontal, 20)
            .padding(.bottom, 14)
    }
}

// MARK: - Content
fileprivate extension EventsView {
    @ViewBuilder
    func companyEvents() -> some View {
        LazyVGrid(columns: gridLayout, spacing: 30) {
            ForEach(Company.allCases.indices, id: \.self) { index in
                let company = Company.allCases[index]
                
                eventCell(for: company, at: index)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 35)
        .background(border())
    }
    
    @ViewBuilder
    func eventCell(for company: Company, at index: Int) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundStyle(companyCellStates[index] ? .red : .gray8)
            .frame(width: 50, height: 50)
            .onChange(of: payload, { oldValue, newValue in
                if company.payload == newValue {
                    companyCellStates[index] = true
                }
            })
    }
    
    func border() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            )
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
