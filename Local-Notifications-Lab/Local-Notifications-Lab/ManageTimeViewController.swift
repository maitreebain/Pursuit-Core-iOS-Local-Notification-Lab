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
    
    private var refreshControl: UIRefreshControl!
    
    private var notifications = [UNNotificationRequest]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        center.delegate = self
        
        configureRefreshControl()
        checkNotifAuth()
        loadNotifs()
    }
    
    private func configureRefreshControl() {
      refreshControl = UIRefreshControl()
      tableView.refreshControl = refreshControl
      refreshControl.addTarget(self, action: #selector(loadNotifs), for: .valueChanged)
    }
    
    @objc private func loadNotifs() {
        pendingNotification.getPendingNotifications { (requests) in
            self.notifications = requests
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func checkNotifAuth() {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("error requesting authorization: \(error)")
                return
            }
            if granted {
                print("access granted")
            } else {
                print("access denied")
            }
        }
    }
    
}

extension ManageTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        let notification = notifications[indexPath.row]
        cell.textLabel?.text = notification.content.title
        cell.detailTextLabel?.text = notification.content.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeNotification(forIndexPath: indexPath)
        }
    }
    
    private func removeNotification(forIndexPath indexPath: IndexPath) {
        let notification = notifications[indexPath.row]
        let identifier = notification.identifier
        
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        notifications.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension ManageTimeViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}

extension ManageTimeViewController: SettingTimerControllerDelegate {
    func didCreateNotification(_ viewController: SettingTimerController) {
        loadNotifs()
    }
}
