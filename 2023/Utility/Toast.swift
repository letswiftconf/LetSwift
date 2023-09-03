//
//  Toast.swift
//  LetSwift
//
//  Created by Dongju on 2022/11/12.
//

import UIKit
import SnapKit

public class Toast {
    var container = UIView()
    
    var toastContainer: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.orange.withAlphaComponent(0.9)
        view.layer.cornerRadius = 6
        view.clipsToBounds  =  true
        return view
    }()
    
    var toastLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private var isHidden = true
    
    static let shared: Toast = { return Toast() } ()
    private func show(parentView: UIView, message: String, delay: TimeInterval,completion: ((Bool) -> Void)? = nil) {
        toastLabel.text = message
        toastContainer.addSubview(toastLabel)
        parentView.addSubview(toastContainer)
        
        toastLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(11)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.greaterThanOrEqualTo(20)
        }
        
        toastContainer.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.equalTo(parentView.safeAreaLayoutGuide.snp.top).inset(15)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: { [weak self] in
                guard let self = self else { return }
                self.toastContainer.alpha = 0.0
            }, completion: {  [weak self]  _ in
                guard let self = self else { return }
                self.isHidden = !self.isHidden
                self.toastContainer.removeFromSuperview()
                guard let completionClosure = completion else { return }
                completionClosure(true)
            })
        })
    }
   
    func show(message: String, delay: TimeInterval = 5.0, completion: ((Bool) -> Void)? = nil) {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            if keyWindow != nil {
                if #available(iOS 10.0, *) { keyWindow!.layoutIfNeeded()}
                if self.isHidden {
                    self.isHidden = !self.isHidden
                    self.show(parentView:keyWindow!,message: message, delay: delay, completion: completion)
                }
            }
        }
    }
    
    
}
