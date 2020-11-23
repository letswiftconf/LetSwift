//
//  AppSourceCodeItemView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/24.
//

import SwiftUI

struct AppSourceCodeItemView: View {
    let width: CGFloat
    let height: CGFloat
    
    @State private var presentAppSourceCode = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
            Text("앱 소스코드")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
        }
        .modifier(RoundedMask())
        .modifier(Shadow())
        .sheet(isPresented: $presentAppSourceCode) {
            Safari(url: .appSourceCode)
        }
        .onTapGesture {
            presentAppSourceCode.toggle()
        }
    }
}

// MARK: - Preview
struct AppSourceCodeItemView_Previews: PreviewProvider {
    static var previews: some View {
        AppSourceCodeItemView(width: .homeItemHeight, height: .homeItemHeight)
            .previewAsComponent()
    }
}
