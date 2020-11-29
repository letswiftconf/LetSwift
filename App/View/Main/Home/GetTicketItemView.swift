//
//  GetTicketItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct GetTicketItemView: View {
    let width: CGFloat
    let height: CGFloat
    
    @State private var presentGetTicket = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("ticket")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
            Text("티켓 구매")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
        .sheet(isPresented: $presentGetTicket) {
            Safari(url: .getTicket)
        }
        .onTapGesture {
            presentGetTicket.toggle()
        }
    }
}

// MARK: - Preview
struct GetTicketItemView_Previews: PreviewProvider {
    static var previews: some View {
        GetTicketItemView(width: .homeItemHeight, height: .homeItemHeight)
            .previewAsComponent()
    }
}
