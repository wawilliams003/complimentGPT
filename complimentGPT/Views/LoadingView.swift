//
//  LoadingView.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//

import UIKit

// Typing dots indicator view
final class TypingDotsView: UIView {
    private let dotSize: CGFloat = 20
    private let dotSpacing: CGFloat = 6
    private var dots: [UIImageView] = [UIImageView(image: UIImage(named: "aibot"))]
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        for i in 0..<3 {
            let dot = UIImageView(image: UIImage(named: "aibot"))
            dot.tintColor = .white
            dot.backgroundColor = .secondaryLabel
            dot.layer.cornerRadius = dotSize / 2
            dot.translatesAutoresizingMaskIntoConstraints = false
            addSubview(dot)
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: dotSize),
                dot.heightAnchor.constraint(equalToConstant: dotSize),
                dot.centerYAnchor.constraint(equalTo: centerYAnchor),
                dot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(i) * (dotSize + dotSpacing))
            ])
            dots.append(dot)
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func startAnimating() {
        for (i, dot) in dots.enumerated() {
            let delay = Double(i) * 0.2
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1.0
            animation.toValue = 1.4
            animation.duration = 0.6
            animation.autoreverses = true
            animation.repeatCount = .infinity
            animation.beginTime = CACurrentMediaTime() + delay
            dot.layer.add(animation, forKey: "pulse")
        }
    }

    func stopAnimating() {
        for dot in dots {
            dot.layer.removeAllAnimations()
        }
    }
}
