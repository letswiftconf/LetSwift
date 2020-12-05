//
//  AddPassView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2020/11/30.
//

import SwiftUI
import PassKit

struct AddPassView: UIViewControllerRepresentable {
    let pass: PKPass
    
    // MARK: - Representable
    func makeUIViewController(context: Context) -> PKAddPassesViewController {
        guard let viewController = PKAddPassesViewController(pass: pass) else {
            fatalError()
        }
//        let navigation = UINavigationController(rootViewController: preview)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: PKAddPassesViewController, context: Context) {
        
    }
}

// MARK: - Preview
struct AddPassView_Previews: PreviewProvider {
    static var previews: some View {
        guard let fileURL = Bundle.main.url(forResource: "LetSwift", withExtension: "pkpass") else {
            return AnyView(EmptyView())
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            return AnyView(EmptyView())
        }
        guard let pass = try? PKPass(data: data) else {
            return AnyView(EmptyView())
        }
        return AnyView(AddPassView(pass: pass).previewAsScreen())
    }
}
