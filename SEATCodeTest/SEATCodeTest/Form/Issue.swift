//
//  DetailViewModel.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import Foundation
import SwiftData

@Model
class Issue {
    @Attribute(.unique) var issueId: UUID
    var firstName: String
    var lastName: String
    var email: String
    var phone: String?
    var date: Date
    let issueDescription: String
    
    init(firstName: String, lastName: String, email: String, phone: String? = nil, date: Date, issueDescription: String) {
        self.issueId = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.date = date
        self.issueDescription = issueDescription

    }
}
