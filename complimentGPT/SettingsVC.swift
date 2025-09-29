//
//  SettingsVC.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/18/25.
//

import UIKit
import SnapKit
import SafariServices

class SettingsVC: UIViewController {

    let tableview: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self,
                           forCellReuseIdentifier: CustomCell.identifier)
        
        return tableView
    }()
    
    //let height: CGFloat = 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.primary
        
        //stackview.backgroundColor = .blue
        setupView()
        navButtons()
        // Do any additional setup after loading the view.
    }
    
    func openPrivacyPolicy() {
           if let url = URL(string: "https://wawilliams003.github.io/complimentsAI-pages/privacy.html") {
               let safariVC = SFSafariViewController(url: url)
               present(safariVC, animated: true, completion: nil)
           }
       }
    
    func openTermsOfService() {
         if let url = URL(string:
                            "https://wawilliams003.github.io/complimentsAI-pages/terms.html") {
             let safariVC = SFSafariViewController(url: url)
             present(safariVC, animated: true, completion: nil)
         }
     }
 
    
    //MARK: - Helper Functions
    func navButtons() {
        let image = UIImage(systemName: "star.fill")
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightNavButton))
        rightBtn.tintColor = .white
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    func setupView() {
        navigationItem.titleView = .titleViewLabel(text: "Settings",
                                                   view: self.view)
        view.addSubview(tableview)
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    
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


extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("INDEX SECTION: \(indexPath.section)")
        
        print("INDEX ROW: \(indexPath.row)")
       
        switch indexPath.section  {
        case 0:
            print("SHOW PIRCHASE")
            
        case 1:
            navigationController?.pushViewController(PhotoComplimentVC(), animated: true)
            
        case 2:
            navigationController?.pushViewController(NotificationVC(), animated: true)
            
           // navigationController?.pushViewController(DescribeSomeoneVC(), animated: true)
            
        case 3:
            openTermsOfService()
            
        case 4:
            openPrivacyPolicy()
            
        case 5:
            print("4")
        default: break


        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Subscription",
                           subtitle: "Unlock all features",
                           icon: "crown.fill")
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Restore Purchase",
                           subtitle: "Restore previous purchase",
                           icon: "arrow.counterclockwise")
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Enable Notifications",
                           subtitle: "Get a new Compliment every day",
                           icon: "bell.fill")
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Terms of Service",
                           subtitle: "View terms of servicee",
                           icon: "doc.on.doc")
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Privacy Policy",
                           subtitle: "Review privacy policy",
                           icon: "hand.raised.fingers.spread.fill")
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            cell.configure(title: "Rate",
                           subtitle: "Let us know how you like it",
                           icon: "star.fill")
            return cell
            
//        case 5:
//            let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
//            cell.configure(title: "Enable Notifications",
//                           subtitle: "Get a new Compliment every day",
//                           icon: "bell.fill")
//            return cell

            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
