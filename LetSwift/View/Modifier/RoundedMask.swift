//
//  RoundedMask.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/01.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct  RoundedMask: ViewModifier {
    func body(content: Content) -> some View {
        let mask = RoundedRectangle(cornerRadius: 26, style: .continuous)
        return content
        .clipShape(mask)
    }
}
