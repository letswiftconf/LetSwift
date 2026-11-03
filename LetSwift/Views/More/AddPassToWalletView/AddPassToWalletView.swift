//
//  AddPassToWalletView.swift
//  LetSwift
//
//  Created by BumMo Koo on 11/21/25.
//

import SwiftUI
import PassKit
import OSLog

private let logger = Logger(subsystem: "kr.codesquad.jk.letswift", category: "AddPassToWalletView")

struct AddPassToWalletView: UIViewControllerRepresentable {
    let pass: PKPass
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> PKAddPassesViewController {
        let controller = PKAddPassesViewController(pass: pass)!
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PKAddPassesViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }

    @MainActor
    class Coordinator: NSObject, PKAddPassesViewControllerDelegate {
        let dismiss: DismissAction

        init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }

        nonisolated func addPassesViewControllerDidFinish(_ controller: PKAddPassesViewController) {
            logger.debug("Pass view controller dismissed")
            Task { @MainActor in
                dismiss()
            }
        }
    }
}