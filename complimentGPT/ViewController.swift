//
//  ViewController.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/15/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorTheme.primary
        tableView.register(WelcomeCell.self, forCellReuseIdentifier: WelcomeCell.identifier)
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.register(UnlockFeaturesCell.self, forCellReuseIdentifier: UnlockFeaturesCell.identifier)
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorTheme.primary
        tableView.backgroundColor = ColorTheme.primary
        //self.view.backgroundColor = .red
        setupViews()
        
        // Do any additional setup after loading the view.
    }

    
    func setupViews() {
        navigationItem.titleView = .titleViewLabel(text: "ComplimentGPT",
                                                   view: self.view)
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // or .configureWithTransparentBackground()
        appearance.backgroundColor = ColorTheme.primary
        navigationController?.navigationBar.standardAppearance = appearance
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
        navButtons()
    }
    
    //MARK: - Helper Functions
    func navButtons() {
        let image = UIImage(systemName: "star.fill")
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightNavButton))
        rightBtn.tintColor = .white
        navigationItem.rightBarButtonItem = rightBtn
        
        let image_ = UIImage(systemName: "person.fill")
        let leftBtn = UIBarButtonItem(image: image_, style: .plain, target: self, action: #selector(leftNavButton))
        leftBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = leftBtn
        
        
    }
    
    
    @objc func leftNavButton() {
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }

    
    @objc func rightNavButton() {
        self.present(PaymentVC(), animated: true)

    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeCell.identifier, for: indexPath) as! WelcomeCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Upload a Photo",
                           subtitle: "AI will create compliments from your photo",
                           icon: "photo.fill")
//            cell.headerLabel.text = "AI will create compliments from your photo"
//            cell.subtitleLabel.text = "AI will create compliments from your photo"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Describe Someone", subtitle:
                            "Enter info AI will create compliments",
                           icon: "person.fill")
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "History",
                           subtitle: "Previous Compliments",
                           icon: "arrow.counterclockwise")
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: UnlockFeaturesCell.identifier, for: indexPath) as! UnlockFeaturesCell
            //cell.headerLabel.text = "Unlock all Features"
            //cell.subtitleLabel.text = "AI Compliments is free to try, you can unlock all features for a monthly fee"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            print("SHOW PIRCHASE")
            
        case 1:
            navigationController?.pushViewController(PhotoComplimentVC(), animated: true)
            
        case 2:
            navigationController?.pushViewController(DescribeSomeoneVC(), animated: true)
            
        case 3:
            navigationController?.pushViewController(HistoryVC(), animated: true)
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 115
        } else if indexPath.section == 4 {
            return 125
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = .clear
        }
    }
}
