import ActivityKit
import WidgetKit
import SwiftUI

struct LocationWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LocationAttributes.self) { context in
            LocationLockScreenBannerView(state: context.state.movingState)
        } dynamicIsland: { context in
            /// MARK: - DynamicIsland는 추가 구현이 필요한 상태.
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("")
                }
            } compactLeading: {
                Text("")
            } compactTrailing: {
                Text("")
            } minimal: {
                Text("")
            }
        }
    }
}

struct LocationLockScreenBannerView: View {
    let state: LocationAttributes.MovingState
    
    var body: some View {
        ZStack(alignment: .leading) {
            switch state {
            case let .going(distance):
                Image("lockScreenBannerBackground")
                    .resizable()
                
                VStack(alignment: .leading) {
                    Text("행사장까지 남은 거리")
                        .font(.custom("NotoSansKR-Medium", size: 14))
                        .foregroundColor(Color(hex: "545454"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 15) {
                        Text("\(distance, specifier: "%.2f")")
                            .font(.custom("Poppins-ExtraBold", size: 42))
                        
                        Text("km")
                            .font(.custom("Poppins-ExtraBold", size: 30))
                    }
                    .foregroundColor(Color(hex: "0A0A0A"))
                }
                .padding(.leading, 28)
                
            case .arrived:
                Image("arrivedLockScreenBanner")
                    .resizable()
            }
        }
        .frame(height: 130)
    }
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
