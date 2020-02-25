//
//  ViewController.swift
//  Local-Notifications-Lab
//
//  Created by Maitree Bain on 2/23/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

protocol SettingTimerControllerDelegate {
    func didCreateNotification(_ viewController: SettingTimerController)
}

class SettingTimerController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var timerButton: UIButton!
    
    var delegate: SettingTimerController!
    
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = textField.text ?? ""
        content.body = "Notification"
        content.subtitle = "Alert"
        content.sound = .default
        
        
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func FinishedButtonPressed(_ sender: UIButton) {
    }
}
