//
//  HistoryCell.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/17/25.
//

import UIKit
import SnapKit


class HistoryCell: UITableViewCell {
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
    
    let headerIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "text.bubble")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
//        imageView.snp.makeConstraints { (make) in
//            make.width.height.equalTo(24)
//        }
        return imageView
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Text Compliment"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerIconImageView, headerLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        view.layer.cornerRadius = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        
        
        //view.layer.borderWidth = 1.25
       // view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "20s"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let complimentLabel: UILabel = {
        let label = UILabel()
        label.text = "The Compliment will show Here, I think the AI will creae something cool"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "doc.on.doc.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        //button.setTitle("Copy", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        //button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(handleCopy), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.arrow.up.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        //button.setTitle("Copy", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        //button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(handleCopy), for: .touchUpInside)
        return button
    }()
    
    lazy var copyContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.08)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
        return view
    }()
    
    lazy var shareContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.08)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [copyContentView, shareContentView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = ColorTheme.primary
        addSubview(containerView)
        containerView.addSubview(headerContainerView)
        containerView.addSubview(complimentLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(buttonStackView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        
        headerContainerView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(containerView).inset(16)
            make.height.equalTo(30)
            make.width.equalTo(170)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(containerView).inset(16)
            
        }

        buttonStackView.snp.makeConstraints { (make) in
           // make.top.equalTo(complimentLabel.snp.bottom).offset(5)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        complimentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerContainerView.snp.bottom).offset(-15)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(buttonStackView.snp.top).offset(5)
        }
        
    }
    
    //MARK: -
    
    @objc func handleCopy() {
        
    }
}
