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
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: "wand.and.stars.inverse", withConfiguration: imageConfiguration)//UIImage(named: "aibot")
        config.image = image
        config.baseBackgroundColor = .link
        config.baseForegroundColor = .systemYellow
        config.cornerStyle = .capsule
        var attributedTitle = AttributedString("Continue for free!")
        attributedTitle.font = .systemFont(ofSize: 30, weight: .semibold)
        attributedTitle.foregroundColor = .white
        attributedTitle.underlineStyle = .single
        config.attributedTitle = attributedTitle
        config.imagePadding = 5
        config.imagePlacement = .trailing
        button.configuration = config
        button.addTarget(self, action: #selector(handlePurchase), for: .touchUpInside)
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
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        purchaseBtn.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
            make.leading.trailing.equalTo(containerView).inset(40)
        }
    
    }
    
    
    @objc func handlePurchase() {
        Task {
          await  StorekitManager.shared.makePayment()
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
