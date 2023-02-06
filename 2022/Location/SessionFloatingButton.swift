import SwiftUI

@available(iOS 16.1, *)
struct SessionFloatingButton: View {
    @ObservedObject var store: LiveActivityStore
    
    var body: some View {
        Button(action: store.buttonTapped) {
            let text = store.state.isLiveActivityVisible ?
            "DeActivate" :
            "Activate"
            Text("\(text) Live Activitiy")
                .font(.bodyBold)
                .padding()
                .foregroundColor(.white)
                .background(.orange)
                .cornerRadius(10)
        }
        .padding(.trailing, 8)
        .opacity(store.state.isButtonVisible ? 1.0 : .zero)
        .alert(
            "알림",
            isPresented: .constant(store.state.error != nil)
        ) {
            Button(action: { store.state.error = nil }) {
                Text("확인")
            }
        } message: {
            Text(store.state.error?.localizedDescription ?? "잠시 후 다시 시도해주세요.")
        }
    }
}
