//
//  PendingNotifs.swift
//  Local-Notifications-Lab
//
//  Created by Maitree Bain on 2/23/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation
import UserNotifications

class PendingNotification {
  public func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> ()) {
    UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
      print("there are \(requests.count) pending requests.")
      completion(requests)
    }
  }
}
