import SwiftUI

@available(iOS 16.1, *)
struct SessionFloatingButton: View {
    @ObservedObject var store: LiveActivityStore
    @ObservedObject var viewModel: LiveActivityViewModel = LiveActivityViewModel()
    
    var body: some View {
        Button(action: store.buttonTapped) {
            Text(viewModel.getTitleText(store.state.isLiveActivityVisible))
                .font(.bodyBold)
                .padding()
                .foregroundColor(.white)
                .background(viewModel.getBackgroundColor(store.state.isLiveActivityVisible))
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

struct SessionFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.1, *) {
            SessionFloatingButton(store: .live)
        } else {
            // Fallback on earlier versions
        }
    }
}

