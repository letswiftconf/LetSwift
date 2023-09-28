//
//  SelfieFrameCarouselView.swift
//  LetSwift
//
//  Created by 김두리 on 2023/09/29.
//

import SwiftUI

struct SelfieFrameCarouselView<Content: View,T: Identifiable>: View {
    
    @Binding var index: Int
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var content: (T) -> Content
    var list: [T]
    var spacing: CGFloat
    var size: CGFloat
    
    init(spacing: CGFloat = 30, size: CGFloat, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content){
        
        self.list = items
        self.spacing = spacing
        self.size = spacing
        self._index = index
        self.content = content
    }
    
    var body: some View{
        
        GeometryReader { geometry in
            
            let adjustWidth = (size / 2) + (spacing)
            let padding = geometry.size.width / 2
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item).frame(width: size)
                    
                }
            }
            .padding(.horizontal, padding - spacing)
            .offset(x: currentIndex == 0 ? size/2 : CGFloat(currentIndex) * -adjustWidth)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        
                        let progress = -(value.translation.width) / adjustWidth
                        let direction = progress > 0 ? 1 : -1
                        
                        currentIndex = max(min(currentIndex + Int(direction), list.count - 1), 0)
                        currentIndex = index
                    })
                    .onChanged({ value in
                        let progress = -(value.translation.width) / adjustWidth
                        let direction = progress > 0 ? 1 : -1
                        
                        index = max(min(currentIndex + direction, list.count - 1), 0)
                    })
            )
        }
        // Animatiing when offset = 0
        .animation(.easeInOut, value: offset == 0)
    }
    
    // Fetching Index...
    func getIndex(item: T)->Int{
        let index = list.firstIndex { currentItem in
            return currentItem.id == item.id
        } ?? 0
        
        return index
    }
}
