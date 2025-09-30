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
    
    var complimentViewHeightConstraint = 250
    
    let complimentContentView: UIView = {
        let view = UIView()
       // view.isHidden = true
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
       // view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
//        label.text = "You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you.   You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you."
        
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        //label.contentMode = .topLeft
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
    
    lazy var generateButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "wand.and.stars.inverse", withConfiguration: imageConfiguration)//UIImage(named: "aibot")
        config.image = image
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        var attributedTitle = AttributedString("Generate")
        attributedTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        attributedTitle.foregroundColor = .white
        attributedTitle.underlineStyle = .single
        config.attributedTitle = attributedTitle
        config.imagePadding = 8
        config.imagePlacement = .leading
        button.configuration = config
        button.addTarget(self, action: #selector(handleGenerate), for: .touchUpInside)
        return button
    }()
    
    lazy var generateContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1
        view.addSubview(generateButton)
        generateButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        
        return view
    }()
    
    lazy var infoContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1
        view.addSubview(freeComplimentsLabel)
        view.addSubview(upgradeButtonContentView)
        freeComplimentsLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        upgradeButtonContentView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(32)
        }
        return view
    }()
    
    let freeComplimentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        var attributedText = NSMutableAttributedString(string: "Free compliments: \n")
        attributedText.addAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .regular)], range: NSRange(location: 0, length: attributedText.string.count))
        attributedText.append(NSAttributedString(string: "\(3)", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold)]))
        label.textColor = .white
        label.attributedText = attributedText
        return label
    }()
    
    lazy var upgradeButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .semibold)
        let image = UIImage(systemName: "wand.and.stars.inverse", withConfiguration: imageConfiguration)//UIImage(named: "aibot")
        config.image = image
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .systemYellow
        //config.cornerStyle = .capsule
        var attributedTitle = AttributedString("Upgrade")
        attributedTitle.font = .systemFont(ofSize: 15, weight: .semibold)
        attributedTitle.foregroundColor = .white
        attributedTitle.underlineStyle = .single
        config.attributedTitle = attributedTitle
        config.imagePadding = 5
        config.imagePlacement = .leading
        button.configuration = config
        button.addTarget(self, action: #selector(handleGenerate), for: .touchUpInside)
        return button
    }()
    
    lazy var upgradeButtonContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow.withAlphaComponent(0.1)//ColorTheme.primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.systemYellow.withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 1
        view.addSubview(upgradeButton)
        upgradeButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
            //make.width.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
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
    
    
    let historyHeaderView: HistoryHeaderView = {
        return HistoryHeaderView()
    }()
    
    
    let historyStackView: UIStackView = {
        var stackView = UIStackView()

        //var sorted = ComplimentStorage.load().sorted(by: { $0.date > $1.date })
        var sorted = ComplimentStorage.load().filter({$0.type == .description})
        sorted = Array(sorted.prefix(5))
        sorted.forEach { (compliment) in
            stackView.addArrangedSubview(HistoryView(compliment: compliment))
        }
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    let loadingView: TypingDotsView = {
        let view = TypingDotsView()
        return view
    }()
    
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Compliment Lives here"
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        textView.delegate = self
        navButtons()
        loadingView.startAnimating()
        //textView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
//    override func becomeFirstResponder() -> Bool {
//        textView.becomeFirstResponder()
//        return true
//    }
    
    //MARK: - Button Actions
    @objc func handleGenerate() {

        let trimmedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty, trimmedText != "." else {
            print("Please add some text")
            return
        }
        let compliment = Compliment(text: trimmedText,
                                    date: Date(), type: .description)
        ComplimentStorage.save(compliment)
        textView.text = ""
    }
    
    @objc func handleCopy() {
        UIPasteboard.general.string = textView.text
        
    }
   

    func textViewDidChange(_ textView: UITextView) {
        let maxCharacters = 150
        if textView.text.count > maxCharacters {
            textView.text = String(textView.text.prefix(maxCharacters))
            print("Limit reached")
        }
        textCountLabel.text = "\(textView.text.count)/\(maxCharacters)"
    }
    
    func navButtons() {
        let image = UIImage(systemName: "star.fill")
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightNavButton))
        rightBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    let recentLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Compliments"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.white
        return label
    }()
  
    
    @objc func rightNavButton() {
        
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
        view.backgroundColor = ColorTheme.primary
        navigationItem.titleView = .titleViewLabel(text: "ComplimentGPT", view: view)
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
        complimentLabelCV.addSubview(loadingView)
        complimentContentView.addSubview(buttonStackView)
        mainContentView.addSubview(generateContentView)
        mainContentView.addSubview(infoContentView)
        mainContentView.addSubview(historyHeaderView)
        mainContentView.addSubview(historyStackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()                // top/left/bottom/right to scrollView
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.bottom.greaterThanOrEqualTo(historyHeaderView.snp.bottom).offset(400)// important for vertical scroll
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
            make.height.greaterThanOrEqualTo(180)
           // make.height.greaterThanOrEqualTo(complimentViewHeightConstraint)
        }
        
        complimentLabelCV.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(16)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-16)
            //make.bottom.equalTo(buttonStackView.snp.top).offset(10)
            //make.height.greaterThanOrEqualTo(200)
        }
        
        complimentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        shareContentView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        generateContentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(complimentContentView.snp.bottom).offset(16)
            make.height.equalTo(80)
        }
        
        infoContentView.snp.makeConstraints { make in
            make.top.equalTo(generateContentView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        historyHeaderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(infoContentView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        historyStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(historyHeaderView.snp.bottom)
            //make.height.equalTo(70)
            make.bottom.equalToSuperview().inset(16)
        }
        
        
        loadingView.snp.makeConstraints { make in
           // make.edges.equalToSuperview().offset(30)
            make.centerX.centerY.equalTo(complimentLabelCV.snp.center)
        }
//        placeHolderLabel.snp.makeConstraints { make in
//            make.centerY.centerX.equalToSuperview()
//        }
        
    }
}
