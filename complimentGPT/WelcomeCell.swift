//
//  CustomCell.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/15/25.
//

import Foundation
import UIKit
import SnapKit


class WelcomeCell: UITableViewCell {
    
    static let identifier = "WelcomeCell"
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.25
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Compliment GPT"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get daily compliments from GPT-3.5!"
        label.textColor = UIColor.lightText.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let amoutLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "3 free compliments left!"
        label.textColor = UIColor.lightText.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let giftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gift")
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(welcomeLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(amoutLeftLabel)
        containerView.addSubview(giftImageView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().offset(20)
            make.height.equalTo(25)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        giftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.height.width.equalTo(20)
        }
        
        amoutLeftLabel.snp.makeConstraints { make in
            make.leading.equalTo(giftImageView.snp.trailing).offset(7)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
       // containerView.snapshotView(afterScreenUpdates: false)
    }
    
}
