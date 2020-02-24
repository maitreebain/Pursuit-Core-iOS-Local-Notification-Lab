//
//  ViewController.swift
//  Local-Notifications-Lab
//
//  Created by Maitree Bain on 2/23/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class SettingTimerController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }


}

extension SettingTimerController: UITextFieldDelegate {
    
}
