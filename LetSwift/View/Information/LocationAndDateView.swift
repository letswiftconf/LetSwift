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
        VStack {
            locationTitle
            dateTitle
            HStack(spacing: 12) {
                mapBtn
                calendarBtn
            }
            .padding(.top, 14)
            .padding(.bottom, 19)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.grayRec)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
        
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
        .padding(.leading, 11)
        .padding(.top, 18)
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 11)
    }
    
    var mapBtn: some View {
        Button {
            print(#fileID, #function, #line, "- 지도")
        } label: {
            Text("지도")
                .foregroundStyle(Color.black)
                .font(.medium(size: 14))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 38)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.leading)
    }
    
    var calendarBtn: some View {
        Button {
            print(#fileID, #function, #line, "- 캘린더 등록")
        } label: {
            Text("캘린더 등록")
                .foregroundStyle(Color.black)
                .font(.medium(size: 14))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 38)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.trailing)
    }
}

#Preview {
    LocationAndDateView()
}
