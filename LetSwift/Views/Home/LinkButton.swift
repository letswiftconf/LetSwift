//
//  LinkButton.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/28.
//

import SwiftUI

struct LinkButton: View {
  var title: String
  var icon: String
  var onTapGesture: () -> Void

  var body: some View {
    VStack(spacing: 12) {
      Text(Image(systemName: icon))
        .font(.system(size: 24, weight: .semibold))
        .foregroundStyle(.background4)
      
      Text(title)
        .font(.system(size: 14, weight: .regular))
        .foregroundStyle(.title2)
    }
    .padding(.vertical, 28)
    .frame(maxWidth: .infinity)
    .background(backgroundView)
    .contentShape(Circle())
    .onTapGesture(perform: onTapGesture)
  }

  @ViewBuilder
  private var backgroundView: some View {
    if #available(iOS 26.0, *) {
      Circle()
        .foregroundStyle(.clear)
        .glassEffect(.regular.interactive())
    } else {
      Circle()
        .fill(.ultraThinMaterial)
    }
  }
}

#Preview {
  HStack {
    LinkButton(title: "뉴스레터 구독", icon: "envelope.open.fill", onTapGesture: {})
    LinkButton(title: "홈페이지", icon: "display", onTapGesture: {})
    LinkButton(title: "티켓 구매", icon: "ticket.fill", onTapGesture: {})
  }
  .padding()
  .background(.background5)
}

#Preview("home") {
  HomeView()
}
