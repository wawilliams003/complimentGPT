//
//  HistoryCell.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/17/25.
//

import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    static let identifier: String = "HistoryCell"
    
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
        imageView.tintColor = .white
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
        
        addSubview(containerView)
        containerView.addSubview(imageContainerView)
        imageContainerView.addSubview(cellImageView)
        containerView.addSubview(stackview)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
      
        
        
    }
    
    
    
    
    
}
