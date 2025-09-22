//
//  RecentHistoryView.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//



import UIKit
import SnapKit

class HistoryHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let aiCompliment: UILabel = {
        let label = UILabel()
        label.text = "Recent Compliments"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var aiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.counterclockwise.circle.fill")
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
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(aiComplimentStackview)
        
        aiComplimentStackview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        
        
        
    }
}
