//
//  TimeAxis.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/10/15.
//  Copyright © 2019 gbmksquare. All rights reserved.
//

import SwiftUI

struct TimeAxis: View {
    var hours: ClosedRange<Int>
    var hourHeight: CGFloat = 60
    var hourSpacing : CGFloat = 8
    
    // MARK: - Formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        let labels = hours
            .map { DateComponents(hour: $0) }
            .compactMap { Calendar.current.date(from: $0) }
            .map { Self.dateFormatter.string(from: $0) }
        return VStack(alignment: .trailing, spacing: hourSpacing) {
            ForEach(labels, id: \.self) { label in
                VStack {
                    Text(label)
                    Spacer()
                }
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .frame(height: self.hourHeight)
            }
            Spacer()
                .frame(height: self.hourSpacing)
        }
    }
}

// MARK: - Preview
struct TimeAxis_Previews: PreviewProvider {
    static var previews: some View {
        let hourHeight: CGFloat = 60
        let hourSpacing: CGFloat = 8
        let group = Group {
            HStack(alignment: .top) {
                TimeAxis(hours: 0...23, hourHeight: hourHeight, hourSpacing: hourSpacing)
                VStack(spacing: 0) {
                    ForEach(0..<23) { _ in
                        Group {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 80, height: hourHeight)
                            Rectangle()
                                .foregroundColor(.green)
                                .frame(width: 80, height: hourSpacing)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
//        .environment(\.colorScheme, .dark)
        .previewLayout(.sizeThatFits)
        return group
    }
}
