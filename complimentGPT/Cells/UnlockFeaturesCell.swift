//
//  UnlockFeaturesCell.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/16/25.
//

import UIKit
import SnapKit


class UnlockFeaturesCell: UITableViewCell {
    
    static let identifier = "UnlockFeaturesCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.25
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white//.white.withAlphaComponent(0.5)
       // view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Unlock all Features"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "AI Compliments is FREE to try, UNLOCK all features for a fee."
        label.textColor = UIColor.lightText.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    let subcriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle.fill")
        return imageView
    }()
    
    lazy var  stackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [headerLabel, subtitleLabel])
        stackview.axis = .vertical
        stackview.spacing = 4
        return stackview
    }()
    
    lazy var upgradeButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "crown.fill", withConfiguration: imageConfiguration)//UIImage(named: "aibot")
        config.image = image
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .systemGreen
        //config.cornerStyle = .capsule
//        var attributedTitle = AttributedString("Upgrade")
//        attributedTitle.font = .systemFont(ofSize: 12, weight: .semibold)
//        attributedTitle.foregroundColor = .white
//        attributedTitle.underlineStyle = .single
//        config.attributedTitle = attributedTitle
        config.imagePadding = 5
        config.imagePlacement = .leading
        button.configuration = config
        button.addTarget(self, action: #selector(handleUgrade), for: .touchUpInside)
        return button
    }()
    
    lazy var upgradeButtonContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.2)//ColorTheme.primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 1
        view.addSubview(upgradeButton)
        upgradeButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
            //make.leading.trailing.equalToSuperview().inset(5)
            //make.height.equalTo(44)
            //make.centerX.equalToSuperview()
            //make.width.equalToSuperview().inset(10)
            //make.centerY.equalToSuperview()
        }
        return view
    }()
    
    
    
    @objc func handleUgrade(){
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        self.contentView.addSubview(containerView)
        containerView.addSubview(imageContainerView)
        //containerView.addSubview(cellImageView)
        imageContainerView.addSubview(cellImageView)
        containerView.addSubview(stackview)
        // containerView.addSubview(subcriptionImageView)
        containerView.addSubview(upgradeButtonContentView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        imageContainerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.width.height.equalTo(40)
            imageContainerView.layer.cornerRadius = 20
            imageContainerView.clipsToBounds = true
        }
        
        cellImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        
        stackview.snp.makeConstraints { (make) in
            make.leading.equalTo(imageContainerView.snp.leading).inset(50)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(50)
            
        }
        
        //        subcriptionImageView.snp.makeConstraints { (make) in
        //            make.centerY.equalToSuperview()
        //            //make.top.equalToSuperview().offset(20)
        //            make.trailing.equalToSuperview().inset(10)
        //            make.height.width.equalTo(40)
        //
        //        }
        
        upgradeButtonContentView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        
    }
}
