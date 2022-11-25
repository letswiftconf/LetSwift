import SwiftUI

@available(iOS 16.1, *)
struct SessionFloatingButton: View {
    @ObservedObject var store: LiveActivityStore
    
    var body: some View {
        Button(action: store.buttonTapped) {
            Text("\(store.state ? "DeActivate" : "Activate") Live Activitiy")
                .font(.bodyBold)
                .padding()
                .foregroundColor(.white)
                .background(.orange)
                .cornerRadius(10)
        }
        .padding(.trailing, 8)
    }
}
