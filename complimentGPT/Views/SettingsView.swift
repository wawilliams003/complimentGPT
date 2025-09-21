//
//  SettingsView.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/18/25.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(headerText: String, subtitleText: String, iconImageString: String) {
        self.headerText = headerText
        self.subtitleText = subtitleText
        self.iconImageString = iconImageString
        super.init(frame: .zero)
        
    }
    
    var headerText: String = ""
    var subtitleText: String = ""
    var iconImageString: String = ""
    
    let containerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .clear//.yellow//UIColor.lightGray.withAlphaComponent(0.15)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.25
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        //view.layer.cornerRadius = 8
        return view
    }()
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
       // view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = headerText
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = subtitleText
        label.textColor = UIColor.lightText.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: iconImageString)
        imageView.tintColor = .white
        return imageView
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.forward.circle.fill")
        imageView.tintColor = .white.withAlphaComponent(0.7)
        return imageView
    }()
    
    lazy var  stackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [headerLabel, subtitleLabel])
        stackview.axis = .vertical
        stackview.spacing = 0
        return stackview
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        layer.cornerRadius = 8
        layer.borderWidth = 1.25
        layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        //layer.cornerRadius = 8
        //backgroundColor = .red
        //containerView.backgroundColor = .yellow
        //addSubview(containerView)
        addSubview(imageContainerView)
        imageContainerView.addSubview(cellImageView)
        addSubview(stackview)
        addSubview(arrowImageView)
        
        self.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(70)
            //make.bottom.edges.equalToSuperview().inset(20)
            
           // make.edges.equalToSuperview().inset(20)
        }
//        containerView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.top.equalToSuperview().offset(20)
//            make.height.equalTo(70)
//            //make.edges.equalToSuperview().inset(40)
//        }
        
        imageContainerView.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().inset(16)
            make.height.width.equalTo(44)
            make.centerY.equalToSuperview()
        }
        
        
        cellImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        ///*
        stackview.snp.makeConstraints { (make) in
            make.leading.equalTo(imageContainerView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(15)
        }
         
         //*/
    }
    
}
