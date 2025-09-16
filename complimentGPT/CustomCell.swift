//
//  CustomCell.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/15/25.
//

import UIKit
import SnapKit


class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
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
        //view.layer.cornerRadius = 8
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
        label.text = "Upload Photo"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.lightText.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
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
        stackview.spacing = 4
        return stackview
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        self.contentView.addSubview(containerView)
        containerView.addSubview(imageContainerView)
        //containerView.addSubview(cellImageView)
        imageContainerView.addSubview(cellImageView)
        containerView.addSubview(stackview)
       // containerView.addSubview(headerLabel)
        //containerView.addSubview(subtitleLabel)
        
       
        containerView.addSubview(arrowImageView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        imageContainerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
           // make.leading.equalTo(containerView.snp.leading).inset(16)
            make.top.equalToSuperview().inset(20)
            //make.center.equalToSuperview()
            make.width.height.equalTo(40)
            imageContainerView.layer.cornerRadius = 20
            imageContainerView.clipsToBounds = true
        }
      
        cellImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        
        stackview.snp.makeConstraints { (make) in
            make.leading.equalTo(imageContainerView.snp.leading).inset(50)
            make.center.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(15)
        }
        
    }
}
