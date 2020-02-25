//
//  ViewController.swift
//  Local-Notifications-Lab
//
//  Created by Maitree Bain on 2/23/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

protocol SettingTimerControllerDelegate: AnyObject {
    func didCreateNotification(_ viewController: SettingTimerController)
}

class SettingTimerController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var timerButton: UIButton!
    
    weak var delegate: SettingTimerControllerDelegate?
    
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = textField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        content.body = "\(dateFormatter.string(from: datePicker.date))"
        
        content.subtitle = "Alert"
        content.sound = .default
        
        let identifier = UUID().uuidString
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error adding request: \(error)")
            } else {
                print("request was successfully added")
            }
        }
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        guard sender.date > Date() else {return }
        
        timeInterval = sender.date.timeIntervalSinceNow
    }
    
    @IBAction func FinishedButtonPressed(_ sender: UIButton) {
        createNotification()
        delegate?.didCreateNotification(self)
        let manageTimeVC = ManageTimeViewController()
        
    }
}
