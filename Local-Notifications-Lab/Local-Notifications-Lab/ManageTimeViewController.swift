//
//  ManageTimeViewController.swift
//  Local-Notifications-Lab
//
//  Created by Maitree Bain on 2/23/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ManageTimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let center = UNUserNotificationCenter.current()
    
    private let pendingNotification = PendingNotification()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    

}

extension ManageTimeViewController: UITableViewDelegate {
    
}
