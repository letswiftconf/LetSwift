//
//  WebSourceCodeItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct WebSourceCodeItemView: View {
    let width: CGFloat
    let height: CGFloat
    
    @State private var presentWebSourceCode = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("web")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
            Text("웹 소스코드")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
        .sheet(isPresented: $presentWebSourceCode) {
            #if (iOS)
            Safari(url: .webSourceCode)
            #endif
        }
        .onTapGesture {
            presentWebSourceCode.toggle()
        }
    }
}

// MARK: - Preview
struct WebSourceCodeItemView_Previews: PreviewProvider {
    static var previews: some View {
        WebSourceCodeItemView(width: .homeItemHeight, height: .homeItemHeight)
            .previewAsComponent()
    }
}
