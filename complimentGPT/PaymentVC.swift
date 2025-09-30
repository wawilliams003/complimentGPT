//
//  PaymentVC.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/24/25.
//

import UIKit
import SnapKit

class PaymentVC: UIViewController {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var purchaseBtn: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        let image = UIImage(systemName: "arrowshape.right.fill", withConfiguration: imageConfiguration)//UIImage(named: "aibot")
        config.image = image
        config.baseBackgroundColor = .link
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        var attributedTitle = AttributedString("Continue for FREE")
        attributedTitle.font = .systemFont(ofSize: 30, weight: .medium)
        attributedTitle.foregroundColor = .white
        attributedTitle.underlineStyle = .single
        config.attributedTitle = attributedTitle
        config.imagePadding = 5
        config.imagePlacement = .trailing
        button.configuration = config
        button.addTarget(self, action: #selector(handlePurchase), for: .touchUpInside)
        return button
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "aibot"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        //label.text = "Unlock all features"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: "Unlock all Features \n")
        attributedString.setAttributes([.font: UIFont.systemFont(ofSize: 35, weight: .bold)], range: NSRange(location: 0, length: attributedString.length))
        
        let free = NSAttributedString(string: "App is FREE to try \n", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .semibold)])
        attributedString.append(free)
        
        
        let unlimited = NSAttributedString(string: "🤖 Powerful AI Models \n", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .semibold)])
        attributedString.append(unlimited)
        
        let nitifications = NSAttributedString(string: "🔔 DAILY COMPLIMENTS \n", attributes: [.font: UIFont.systemFont(ofSize: 28, weight: .semibold)])
        attributedString.append(nitifications)
        
        let aiModels = NSAttributedString(string: "🥰 Unlimited Compliments", attributes: [.font: UIFont.systemFont(ofSize: 30, weight: .semibold)])
        attributedString.append(aiModels)
        label.attributedText = attributedString
        //label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    let cancelInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Then $4.99/week | Cancel anytime"
        label.textColor = .darkGray//.withAlphaComponent(0.6)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var dismissBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await StorekitManager.shared.fetchProduct()
        }
        
        setupViews()
        // Do any additional setup after loading the view.
    }
    

    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(purchaseBtn)
        containerView.addSubview(iconImageView)
        containerView.addSubview(headerLabel)
        containerView.addSubview(cancelInfoLabel)
        containerView.addSubview(dismissBtn)
        

        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        purchaseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(containerView).inset(40)
            make.height.equalTo(70)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(100)
            make.centerX.equalTo(purchaseBtn)
            make.height.width.equalTo(100)
        }
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(260)
        }
        
        cancelInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(purchaseBtn.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        dismissBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cancelInfoLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    
    }
    
    
    @objc func handlePurchase() {
        Task {
          await  StorekitManager.shared.makePayment()
        }
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
        
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
