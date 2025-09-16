//
//  DescribeSomeoneVC.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/16/25.
//

import UIKit
import SnapKit

class DescribeSomeoneVC: UIViewController, UITextViewDelegate {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.backgroundColor =  ColorTheme.primary
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    let contentView: UIView = {
        let view = UIView()
        //view.backgroundColor = .darkGray
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    
    let complimentContentView: UIView = {
        let view = UIView()
        //view.backgroundColor = .darkGray
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Describe Someone"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let generateLabel: UILabel = {
        let label = UILabel()
        label.text = "AI Compliment"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let textCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/150"
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let countContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        textView.clipsToBounds = true
        textView.isEditable = true
        textView.textColor = .white
        textView.layer.cornerRadius = 8
        textView.backgroundColor = .white.withAlphaComponent(0.08)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return textView
    }()
    
    let aiCompliment: UILabel = {
        let label = UILabel()
        label.text = "AI Compliment"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var aiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "aibot")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
        }
        return imageView
    }()
    
    lazy var aiComplimentStackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [aiImageView, aiCompliment])
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        stackview.alignment = .leading
        stackview.spacing = 5
        //stackview.backgroundColor = .yellow
        return stackview
    }()
    
    
    let complimentLabel: UILabel = {
        let label = UILabel()
        label.text = "You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you."
        
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let complimentLabelCV: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.08)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1
        return view
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        textView.delegate = self
        //textView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
//    override func becomeFirstResponder() -> Bool {
//        textView.becomeFirstResponder()
//        return true
//    }
    
    
    @objc func handleCopy() {
        UIPasteboard.general.string = textView.text
    }
   

    func textViewDidChange(_ textView: UITextView) {
        textCountLabel.text = "\(textView.text.count)/\(150)"
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DescribeSomeoneVC {
    //MARK: - Setup
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainContentView)
        mainContentView.addSubview(contentView)
        contentView.addSubview(textView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(countContainerView)
        countContainerView.addSubview(textCountLabel)
        mainContentView.addSubview(aiComplimentStackview)
        mainContentView.addSubview(complimentContentView)
        complimentContentView.addSubview(complimentLabelCV)
        complimentLabelCV.addSubview(complimentLabel)
        complimentContentView.addSubview(buttonStackView)
        shareContentView.addSubview(shareButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()                // top/left/bottom/right to scrollView
            make.width.equalTo(scrollView.frameLayoutGuide) // important for vertical scroll
        }
        
        contentView.snp.makeConstraints { make in
            //make.top.equalToSuperview().offset(16)
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.height.equalTo(250)
            
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.height.equalTo(20)
            //make.width.equalTo(150)
        }
        countContainerView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(16)
            make.width.equalTo(60)
            make.height.equalTo(22)
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview().inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20)
        }

        aiComplimentStackview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(contentView.snp.bottom).offset(20)
            //make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        complimentContentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(aiComplimentStackview.snp.bottom).offset(10)
            make.height.equalTo(240)
        }
        
        complimentLabelCV.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(100)        }
        
        complimentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(complimentLabelCV.snp.bottom).offset(10)
            //make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(50)
            
        }
    }
}
