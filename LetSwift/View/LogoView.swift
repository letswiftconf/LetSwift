//
//  LogoView.swift
//  LetSwift
//
//  Created by 김나용 on 2019/12/07.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("Logo_Background"))
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, 30)
        }
        .modifier(RoundedMask())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogoView()
            LogoView()
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
