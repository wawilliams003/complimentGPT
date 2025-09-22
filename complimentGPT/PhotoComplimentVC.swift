//
//  PhotoComplimentVC.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/17/25.
//

import UIKit
import SnapKit

class PhotoComplimentVC: UIViewController {

    //MARK: - Properties
    
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
        view.backgroundColor = .clear
        return view
    }()
    
     var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload photo"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
         label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo")!)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto)))
        return imageView
    }()
    
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "camera.fill")!)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddPhoto)))
        return imageView
    }()
    
    
    lazy var iconContentView: UIView = {
        let view = UIView()
        //view.backgroundColor = .darkGray
        view.backgroundColor = .lightGray.withAlphaComponent(0.8)//.gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        view.layer.borderWidth = 1.5
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            //make.leading.trailing.top.equalToSuperview().inset(16)
            //make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
        return view
    }()
    
    
    lazy var imageContentView: UIView = {
        let view = UIView()
        //view.backgroundColor = .darkGray
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.5
        view.addSubview(headerLabel)
        view.addSubview(imageView)
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview().inset(0)
           // make.edges.equalToSuperview().inset(16)
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
        label.text = "You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you. You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you.   You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you."
        label.font = .systemFont(ofSize: 20, weight: .regular)
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
        navigationItem.titleView = .titleViewLabel(text: "ComplimentGPT",
                                                   view: view)
        setupViews()
        navButtons()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Photo Helper
    @objc func handleAddPhoto() {
        
        presentPhotoActionSheet()
        
        
    }
    
    func presentPhotoActionSheet() {
        
        let actionSheet = UIAlertController(title: "Select Option", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
        
    }
    
    func presentCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func presentPhotoPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
    
    let historyHeaderView: HistoryHeaderView = {
        return HistoryHeaderView()
    }()
    
    let historyStackView: UIStackView = {
        var stackView = UIStackView()

        //var sorted = ComplimentStorage.load().sorted(by: { $0.date > $1.date })
        var sorted = ComplimentStorage.load().filter({$0.type == .photo})
        sorted = Array(sorted.prefix(5))
        sorted.forEach { (compliment) in
            stackView.addArrangedSubview(HistoryView(compliment: compliment))
        }
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    

    
    
    //MARK: - Function Handlers
    
    func navButtons() {
        let image = UIImage(systemName: "star.fill")
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightNavButton))
        rightBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightBtn
    }
  
    
    @objc func rightNavButton() {
        
    }
    
    @objc func handleCopy() {
        
        
    }
    
    @objc func handleGenerate() {
       guard imageView.image != nil else { return }
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        let compliment = Compliment(text: " You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you. ",
                                    date: Date(),
                                    image: imageData,
                                    type: .photo)
        ComplimentStorage.save(compliment)
        
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageContentView)
        imageContentView.addSubview(iconContentView)
        contentView.addSubview(generateContentView)
        contentView.addSubview(infoContentView)
        contentView.addSubview(aiComplimentStackview)
        contentView.addSubview(complimentContentView)
        complimentContentView.addSubview(complimentLabelCV)
        complimentLabelCV.addSubview(complimentLabel)
        complimentContentView.addSubview(shareContentView)
        complimentContentView.addSubview(copyContentView)
       // shareContentView.addSubview(shareButton)
       // copyContentView.addSubview(copyButton)
        generateContentView.addSubview(generateButton)
        //contentView.addSubview(complimentLabel)
        //contentView.addSubview(shareContentView)
        //contentView.addSubview(copyButton)
        //contentView.addSubview(shareButton)
       // contentView.addSubview(copyContentView)
        
       // contentView.addSubview(aiComplimentLabel)
        complimentContentView.addSubview(buttonStackView)
        //contentView.addSubview(generateButton)
        contentView.addSubview(historyHeaderView)
        contentView.addSubview(historyStackView)
        
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            //make.bottom.equalTo(infoContentView.snp.bottomMargin).offset(50)
            make.bottom.greaterThanOrEqualTo(historyHeaderView.snp.bottom).offset(200)
        }
        
        imageContentView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
        
        iconContentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        generateContentView.snp.makeConstraints { (make) in
            make.top.equalTo(complimentContentView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        infoContentView.snp.makeConstraints { (make) in
            make.top.equalTo(generateContentView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        aiComplimentStackview.snp.makeConstraints { (make) in
            make.top.equalTo(imageContentView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(25)
        }
        
        complimentContentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(aiComplimentStackview.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(200)
        }
        
        complimentLabelCV.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(16)
            //make.height.greaterThanOrEqualTo(100)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-16)
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

extension PhotoComplimentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage_ = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        //self.selectedImage = slectedImage_
        self.imageView.image = selectedImage_
        iconContentView.isHidden = true
        picker.dismiss(animated: true)
    }
}
