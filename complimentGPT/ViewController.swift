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
        self.view.backgroundColor = .secondarySystemBackground
        //self.view.backgroundColor = .red
        setupViews()
        
        // Do any additional setup after loading the view.
    }

    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
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
            cell.headerLabel.text = "Upload a Photo"
            cell.subtitleLabel.text = "AI will create compliments from your photo"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.headerLabel.text = "Decribe Someone"
            cell.subtitleLabel.text = "Enter info AI will create compliments"
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.headerLabel.text = "Upload Photo"
            cell.subtitleLabel.text = "AI will create compliments from your photo"
            //cell.backgroundColor = .clear
            
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
            
        case 2:
            navigationController?.pushViewController(DescribeSomeoneVC(), animated: true)
            
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
}
