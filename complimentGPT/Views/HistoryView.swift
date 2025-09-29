//
//  HistoryView.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//

//
//  HistoryCell.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/17/25.
//

import UIKit
import SnapKit


class HistoryView: UIView {
   // static let identifier: String = "HistoryCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var iconString = ""
    var photoCompString = ""
    
//    var complement: Compliment? {
//        didSet {
//            guard let complement else { return }
//            complimentLabel.text = complement.text
//            iconString = complement.type.iconName
//            complement.type == .photo ? (headerLabel.text = "Photo") : (headerLabel.text = "Text")
//            timeLabel.text = .timeAgoString(from: complement.date)
//        }
//    }
    
    fileprivate func setup(_ compliment: Compliment) {
        self.complimentLabel.text = compliment.text
        iconString = compliment.type.iconName
        compliment.type == .photo ? (headerLabel.text = "Photo") : (headerLabel.text = "Text")
        timeLabel.text = .timeAgoString(from: compliment.date)
        guard let data = compliment.image, !data.isEmpty else {
            complimentImageView.isHidden = true
            return
        }
        let image = UIImage(data: data)
        complimentImageView.image = image
    }
    
    init(compliment: Compliment) {
        super.init(frame: .zero)
        
        self.setup(compliment)
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
    
    lazy var headerIconImageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 17)
        let imageView = UIImageView()
        let image = UIImage(systemName: iconString, withConfiguration: configuration)
        imageView.image = image//UIImage(systemName: iconString)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
       // label.text = "TextGPT"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerIconImageView, headerLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
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
//        label.text = "This is an example of a recent history. I am only going to add 5 for now. And see how that looks This is an example of a recent history. I am only going to add 5 for now. And see how that looks"
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
            make.edges.equalToSuperview().inset(4)
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
            make.edges.equalToSuperview().inset(4)
        }
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [copyContentView, shareContentView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var complimentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.white.cgColor//.withAlphaComponent(0.5).cgColor
        imageView.layer.borderWidth = 1.5
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(otherUserImageTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    //MARK: - Helper Functions
    
    @objc func otherUserImageTapped() {
        
        guard let startingFrame = complimentImageView.superview?.convert(complimentImageView.frame, to: nil),
              let image = complimentImageView.image else { return }

        let zoomImageView = UIImageView(image: image)
        zoomImageView.frame = startingFrame
        zoomImageView.contentMode = .scaleAspectFit
        zoomImageView.backgroundColor = .black
        zoomImageView.isUserInteractionEnabled = true

        if let window = self.window {
            window.addSubview(zoomImageView)

            UIView.animate(withDuration: 0.3, animations: {
                zoomImageView.frame = window.frame
                zoomImageView.backgroundColor = .black
            })

            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissZoomedImage(_:)))
            zoomImageView.addGestureRecognizer(tap)
        }
    }
    
    @objc func dismissZoomedImage(_ sender: UITapGestureRecognizer) {
        guard let zoomImageView = sender.view as? UIImageView else { return }

        UIView.animate(withDuration: 0.3, animations: {
            zoomImageView.alpha = 0
        }) { _ in
            zoomImageView.removeFromSuperview()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = ColorTheme.primary
        addSubview(containerView)
        containerView.addSubview(headerContainerView)
        containerView.addSubview(complimentLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(buttonStackView)
        containerView.addSubview(complimentImageView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
            //make.leading.trailing.top.equalToSuperview().inset(16)
            //make.height.greaterThanOrEqualTo(250)
        }
        
        headerContainerView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(containerView).inset(16)
            make.height.equalTo(25)
            make.width.equalTo(85)
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
            make.top.equalTo(headerContainerView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(16)
           // make.bottom.greaterThanOrEqualTo(buttonStackView.snp.top).offset(-10)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-10)
        }
        
        complimentImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
    }
    
    //MARK: -
    
    @objc func handleCopy() {
        
    }
}
