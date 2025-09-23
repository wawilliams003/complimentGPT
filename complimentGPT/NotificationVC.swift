//
//  NoitificationVC.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/22/25.
//

import UIKit
import SnapKit
import UserNotifications

class NotificationVC: UIViewController {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorTheme.primary
        return view
    }()
    
    let scrollview: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = ColorTheme.primary
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Time"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let deliveryTimeLbl: UILabel = {
        let label = UILabel()
        label.text = "Set your daily delivery time"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    var pickerHour: Int = 0
    var pickerMinute: Int = 0
    
    
    
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.contentMode = .scaleAspectFit
        picker.tintColor = .black
        picker.preferredDatePickerStyle = .inline
        picker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        picker.locale = Locale(identifier: "en_US_POSIX")
        //picker.textColor = .black
        //picker.backgroundColor = .white.withAlphaComponent(0.8)
        //picker.layer.cornerRadius = 8
       // picker.clipsToBounds = true
        
        //picker.setValue(UIColor.systemBlue, forKey: "textColor")
        //picker.backgroundColor = .systemGroupedBackground
        return picker
    }()
    
    lazy var pickerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 1.5
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints { (make) in
            
            make.center.equalToSuperview()
            make.width.equalTo(100)
        }
        
        return view
    }()
    
    let previewHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Preview"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let previewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.contentMode = .left
        return label
    }()
   
    lazy var previewLabelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        view.layer.borderWidth = 1.5
        view.addSubview(previewLabel)
        previewLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }

        return view
    }()
    
    lazy var previewContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.5
        view.addSubview(previewHeaderLabel)
        view.addSubview(previewLabelContainerView)
        previewHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        previewLabelContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(previewHeaderLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        return view
    }()
    
    
    lazy var timeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        view.layer.borderWidth = 1.5
        view.addSubview(timeLabel)
        view.addSubview(pickerContainerView)
        view.addSubview(deliveryTimeLbl)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        pickerContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(70)
        }
        
        deliveryTimeLbl.snp.makeConstraints { (make) in
            make.top.equalTo(pickerContainerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().offset(20)
        }
        
        return view
    }()
    
    
    lazy var enableNotificationBtn: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "bell.fill", withConfiguration: imageConfiguration)//UIImage(named: "aibot")
        config.image = image
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        var attributedTitle = AttributedString("Enable Notifications")
        attributedTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        attributedTitle.foregroundColor = .white
        attributedTitle.underlineStyle = .single
        config.attributedTitle = attributedTitle
        config.imagePadding = 8
        config.imagePlacement = .leading
        button.configuration = config
        button.addTarget(self, action: #selector(enableNotificationTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.primary
        navigationItem.titleView = .titleViewLabel(text: "Notification Settings",
                                                   view: self.view)
        
        setupView()
        previewLabel.text = getRandomCompliment()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Helper Functions
    
    @objc func pickerValueChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        //components.calendar.date.
        if let componentHour = components.hour, let componentMinute = components.minute {
            self.pickerHour = componentHour
            self.pickerMinute = componentMinute
            print("Hour: \(componentHour), Minute: \(componentMinute)")
        }
    }
    
    
    @objc func enableNotificationTapped() {
        requestNotificationPermission(at: pickerHour, minute: pickerMinute)
    }
    
    func requestNotificationPermission(at hour: Int, minute: Int) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error)")
            }
            if granted {
                print("Permission granted.")
                self?.scheduleDailyCompliment(at: hour, minute: minute)
                ///print("Notification scheduled.")
                
            } else {
                print("Permission denied.")
            }
        }
    }
    
    func scheduleDailyCompliment(at hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Your Daily Compliment 💖"
        content.body = getRandomCompliment()
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyCompliment", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling: \(error)")
            } else {
                print("✅ Daily compliment scheduled")
            }
        }
    }
    
    let compliments = [
        "You light up the room ✨",
        "You’re a great listener 💬",
        "Your smile makes people’s day 😊",
        "You bring out the best in others 🌟",
        "You have a heart of gold 💛"
    ]

    func getRandomCompliment() -> String {
        return compliments.randomElement() ?? "You’re amazing!"
    }
    
    
    func setupView() {
        view.addSubview(scrollview)
        scrollview.addSubview(containerView)
        containerView.addSubview(timeContainerView)
        containerView.addSubview(previewContainerView)
        containerView.addSubview(enableNotificationBtn)
        
        scrollview.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(1000)
            make.width.equalToSuperview()
        }
        
        timeContainerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(165)
        }
        
        previewContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(timeContainerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        enableNotificationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(previewContainerView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
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
