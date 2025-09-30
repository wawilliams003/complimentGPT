//
//  ShowToast.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/30/25.
//

import UIKit
import SnapKit

extension UIView {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = .systemFont(ofSize: 17, weight: .medium)
        toastLabel.textAlignment = .center
        toastLabel.textColor = .systemYellow
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        toastLabel.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        toastLabel.layer.borderWidth = 1.0
        
        self.addSubview(toastLabel)
        let height: CGFloat = 45
        toastLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(100)
        }
        
        toastLabel.alpha = 0
        
        
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
