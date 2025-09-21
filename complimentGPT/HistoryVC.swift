//
//  HistoryVC.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/17/25.
//

import UIKit
import SnapKit

class HistoryVC: UIViewController {
    
    var compliments: [Compliment] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        return tableView
    }()
    
    lazy var titleViewLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: view.frame.size.width / 2, width: 150, height: 50)
            let string = "History"
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttributes([
                .font: UIFont(name: "HelveticaNeue-CondensedBold", size: 25) ?? UIFont.systemFont(ofSize: 25),
                .kern: 2.0,
                .foregroundColor: UIColor.white
            ], range: NSRange(location: 0, length: string.count))
           // return attributedString
        label.attributedText = attributedString
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 180
        // Do any additional setup after loading the view.
        compliments.append(Compliment(text: "You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you.", Date: Date(), type: .description))
        
        compliments.append(Compliment(text: "You are a great person, keep up the  good work. Youll be great at what you do in no time.", Date: Date(), type: .description))
        
        compliments.append(Compliment(text: "This complient os from a photo. You are becoming a very good software developer, keep up the great work!,\n You are becoming a very good software developer, keep up the great work!. I will never stop buidling something amazing for you. You are a great person, keep up the  good work. Youll be great at what you do in no time.You are a great person, keep up the  good work. Youll be great at what you do in no time", Date: Date(), type: .photo))
        
        tableView.reloadData()
    }
    
    func setupViews() {
        navigationItem.titleView = titleViewLabel
        view.backgroundColor = ColorTheme.primary
        tableView.backgroundColor = ColorTheme.primary
        view.addSubview(tableView)
        tableView.frame = view.bounds
        navButtons()
    }
    
    func navButtons() {
        let image = UIImage(systemName: "star.fill")
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightNavButton))
        rightBtn.tintColor = .white
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    //MARK: - Helper Functions
    
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

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compliments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
        cell.complement = compliments[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let compliment = compliments[indexPath.row]
        let text = compliment.text

        let maxWidth = tableView.bounds.width //- 40 // adjust for padding/margins
        let font = UIFont.systemFont(ofSize: 18, weight: .regular)
        let constraintRect = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [.font: font],
                                            context: nil)
        //return max(boundingBox.height + 20, 150) // Ensure minimum height for other content
        return boundingBox.height + 150 // Add padding for other content
    }
     
}
