//
//  MyPlaygrounds.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/06.
//

import SwiftUI

enum PlaygoundsType: String, CaseIterable {
    case guestBook = "나의기록"
    case myCard = "나의카드"
}

struct MyPlaygrounds: View {
    var viewModel = MyPlaygroundsViewModel()
    @State var segmentationSelection : PlaygoundsType = .guestBook
    @State private var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Picker("", selection: $segmentationSelection) {
                    ForEach(PlaygoundsType.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Spacer()
            }
            
            HStack {
                PlaygroundSimpleRow(guestBook: GuestBookModel(content: viewModel.getContentBySelectedType(segmentationSelection),profile: "person.circle"))
                    .onTapGesture {
                        self.isPresented.toggle()
                      
                    }
                Spacer()
                    .background(Color.blue)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(6)
            .sheet(isPresented: $isPresented) {
                viewModel.getNextView(segmentationSelection)
            }
        }
        
    }
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
    }
}


struct MyPlaygrounds_Previews: PreviewProvider {
    static var previews: some View {
        MyPlaygrounds()
    }
}
