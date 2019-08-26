//
//  ActivityView.swift
//  LetSwift Data Manager
//
//  Created by kor45cw on 26/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        guard let encodedData = DataStore.shared.encodeData(),
            let jsonString = String(data: encodedData, encoding: .utf8) else {
                return UIActivityViewController(activityItems: [], applicationActivities: nil)
        }
        return UIActivityViewController(activityItems: [jsonString],
                                        applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}
