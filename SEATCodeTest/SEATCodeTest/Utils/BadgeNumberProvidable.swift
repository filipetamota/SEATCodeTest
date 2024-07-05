//
//  BadgeNumberProvidable.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 5/7/24.
//

import SwiftUI

protocol BadgeNumberProvidable: AnyObject {
    var applicationIconBadgeNumber: Int { get set }
}

extension UIApplication: BadgeNumberProvidable {}

actor AppAlertBadgeManager {
    
    let application: BadgeNumberProvidable
    
    init(application: BadgeNumberProvidable) {
        self.application = application
    }
    
    @MainActor
    func setAlertBadge(number: Int) {
        application.applicationIconBadgeNumber = number
    }
    
    @MainActor
    func increaseAlertBadge() {
        application.applicationIconBadgeNumber += 1
    }
    
    @MainActor
    func resetAlertBadgetNumber() {
        application.applicationIconBadgeNumber = 0
    }
}
