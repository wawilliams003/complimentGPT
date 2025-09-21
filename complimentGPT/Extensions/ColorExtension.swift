//
//  ColorExtension.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/16/25.
//

import UIKit

extension UIColor {
    convenience init?(hex: String, alpha overrideAlpha: CGFloat? = nil) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        var rgbValue: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&rgbValue) else {
            return nil
        }

        var red, green, blue, alpha: CGFloat

        switch hexString.count {
        case 6:
            red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
            green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255
            blue = CGFloat(rgbValue & 0x0000FF) / 255
            alpha = 1.0

        case 8:
            red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255
            green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255
            blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255
            alpha = CGFloat(rgbValue & 0x000000FF) / 255

        default:
            return nil
        }

        if let overrideAlpha = overrideAlpha {
            alpha = overrideAlpha
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct ColorTheme {
    
    static let primary: UIColor = UIColor(hex: "DB5F5E", alpha: 1)!
}

extension UIView {
    
    static func titleViewLabel(text: String, view: UIView) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: view.frame.size.width / 2, width: 150, height: 50)
            let string = text
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttributes([
                .font: UIFont(name: "HelveticaNeue-CondensedBold", size: 25) ?? UIFont.systemFont(ofSize: 25),
                .kern: 2.0,
                .foregroundColor: UIColor.white
            ], range: NSRange(location: 0, length: string.count))
           // return attributedString
        label.attributedText = attributedString
        return label
    }
    
    
}

