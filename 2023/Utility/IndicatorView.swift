//
//  IndicatorView.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import Foundation
import UIKit

public class IndicatorView {
    var container = UIView()
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    static let shared: IndicatorView = { return IndicatorView() } ()
    
    func show(parentView: UIView) {
        container.frame = parentView.frame
        container.center = parentView.center
        container.backgroundColor = UIColor(white: 0x000000, alpha: 0.0)
        loadingView.frame = CGRect(x:0, y:0, width:100, height:100)
        loadingView.center = parentView.center
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        activityIndicator.color  = .orange
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        parentView.addSubview(container)
        activityIndicator.startAnimating()
        
    }
   
    func show() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            if keyWindow != nil {
                if #available(iOS 10.0, *) { keyWindow!.layoutIfNeeded()}
                self.show(parentView:keyWindow!)
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
        }
    }
}
