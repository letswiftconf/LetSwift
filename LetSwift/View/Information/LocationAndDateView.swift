//
//  LocationAndDateView.swift
//  LetSwift
//
//  Created by 김라영 on 2024/08/28.
//

import SwiftUI

/// 장소&일시
struct LocationAndDateView: View {
    var body: some View {
        VStack(spacing: 0) {
            locationTitle
            dateTitle
            HStack(spacing: 14) {
                mapBtn
                calendarBtn
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.grayRec)
        .clipShape(RoundedRectangle(cornerRadius: 15))        
    }
    
    var locationTitle: some View {
        HStack(spacing: 0) {
            Image("ic_location")
                .padding(.trailing, 8)
            Text("information.location")
                .foregroundStyle(Color.grayIcon)
                .font(.regular(size: 14))
                .padding(.trailing, 18)
            Text("세종대학교 광개토회관")
                .foregroundStyle(Color.white)
                .font(.regular(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 6)
    }
    
    var dateTitle: some View {
        HStack(spacing: 0) {
            Image("ic_calendar")
                .padding(.trailing, 8)
            Text("information.date")
                .foregroundStyle(Color.grayIcon)
                .font(.regular(size: 14))
                .padding(.trailing, 18)
            Text("2024년 11월 25일\n00:00 ~ 00:00")
                .foregroundStyle(Color.white)
                .font(.regular(size: 14))
                .lineSpacing(3)
                .offset(y: 9)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 24)
    }
    
    var mapBtn: some View {
        Button {
            print(#fileID, #function, #line, "- 지도")
        } label: {
            Text("지도")
                .foregroundStyle(Color.black)
                .font(.medium(size: 14))
                .frame(maxWidth: .infinity)
                .frame(height: 38)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    var calendarBtn: some View {
        Button {
            print(#fileID, #function, #line, "- 캘린더 등록")
        } label: {
            Text("캘린더 등록")
                .foregroundStyle(Color.black)
                .font(.medium(size: 14))
                .frame(maxWidth: .infinity)
                .frame(height: 38)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    LocationAndDateView()
}
