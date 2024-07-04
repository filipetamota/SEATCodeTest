//
//  StopModel.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 4/7/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct StopModel: Codable, Hashable {
    let price: Double
    let address: String
    let tripId: Double
    let stopTime: Date
    let point: Coordinates
    let userName: String

    struct Coordinates: Codable, Hashable {
        let latitude: Double
        let longitude: Double
        
        func value() -> CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        private enum CodingKeys: String, CodingKey {
            case latitude = "_latitude"
            case longitude = "_longitude"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        
        price = try container.decode(Double.self, forKey: .price)
        address = try container.decode(String.self, forKey: .address)
        tripId = try container.decode(Double.self, forKey: .tripId)
        stopTime = dateFormatter.date(from: try container.decode(String.self, forKey: .stopTime)) ?? .now
        point = try container.decode(Coordinates.self, forKey: .point)
        userName = try container.decode(String.self, forKey: .userName)
    }
    
    init(price: Double, address: String, tripId: Double, stopTime: Date, point: Coordinates, userName: String) {
        self.price = price
        self.address = address
        self.tripId = tripId
        self.stopTime = stopTime
        self.point = point
        self.userName = userName
    }
    
    static let mock = StopModel(price: 0.0, address: "Mock address", tripId: 1, stopTime: .now, point: Coordinates(latitude: 0.0, longitude: 0.0), userName: "Mock user")
    
    static let empty = StopModel(price: 0.0, address: "", tripId: 0, stopTime: .now, point: Coordinates(latitude: 0.0, longitude: 0.0), userName: "")
}
