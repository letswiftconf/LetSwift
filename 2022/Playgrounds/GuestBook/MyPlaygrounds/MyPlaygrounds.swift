//
//  MyPlaygrounds.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import SwiftUI

struct MyPlaygrounds: View {
    var viewModel = MyPlaygroundsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            viewModel.getNextView(viewModel.hasCheeringCard)
        }
    }
}


struct MyPlaygrounds_Previews: PreviewProvider {
    static var previews: some View {
        MyPlaygrounds()
    }
}
