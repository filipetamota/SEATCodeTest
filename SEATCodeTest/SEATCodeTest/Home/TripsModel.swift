//
//  Model.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 4/7/24.
//

import Foundation
import CoreLocation
import SwiftUI

struct TripsModel {
    let trips: [TripModel]
    var selectedTrip: UUID?
    
    static let empty = TripsModel(trips: [], selectedTrip: nil)
}

struct TripModel: Codable, Hashable {
    let driverName: String
    let status: TripStatus
    let route: String
    let startTime: Date
    let endTime: Date
    let description: String
    let origin: Location
    let destination: Location
    let stops: [Stop]?
    var isSelected: Bool
    let tripId: UUID
    
    struct Location: Codable, Hashable {
        let address: String?
        let point: Coordinates
    }

    struct Stop: Codable, Hashable {
        let id: Int?
        let point: Coordinates?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Int.self, forKey: .id)
            point = try container.decodeIfPresent(Coordinates.self, forKey: .point)
        }
    }

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

    enum TripStatus: String, Codable {
        case ongoing
        case scheduled
        case cancelled
        case finalized
        
        func displayName() -> String {
            return self.rawValue.capitalized
        }
        
        func textColor() -> Color {
            switch self {
            case .ongoing:
                return .yellow
            case .scheduled:
                return .blue
            case .cancelled:
                return .red
            case .finalized:
                return .green
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        
        driverName = try container.decodeIfPresent(String.self, forKey: .driverName) ?? "No driver found"
        status = try container.decode(TripStatus.self, forKey: .status)
        route = try container.decode(String.self, forKey: .route)
        startTime = dateFormatter.date(from: try container.decode(String.self, forKey: .startTime)) ?? .now
        endTime = dateFormatter.date(from: try container.decode(String.self, forKey: .endTime)) ?? .now
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No description available"
        origin = try container.decode(Location.self, forKey: .origin)
        destination = try container.decode(Location.self, forKey: .destination)
        stops = try container.decode([Stop].self, forKey: .stops).filter { $0.point != nil }
        isSelected = false
        tripId = UUID()
    }
    
    init(driverName: String, status: TripStatus = .scheduled, route: String, startTime: Date, endTime: Date, description: String, origin: Location, destination: Location, stops: [Stop]?, isSelected: Bool = false, tripId: UUID = UUID()) {
        self.driverName = driverName
        self.status = status
        self.route = route
        self.startTime = startTime
        self.endTime = endTime
        self.description = description
        self.origin = origin
        self.destination = destination
        self.stops = stops
        self.isSelected = isSelected
        self.tripId = tripId
    }
    
    static let mock = TripModel(driverName: "Mock driver", route: "Mock route", startTime: .now, endTime: .now, description: "Mock description", origin: Location(address: "Mock origin address", point: Coordinates(latitude: 0.0, longitude: 0.0)), destination: Location(address: "Mock destination address", point: Coordinates(latitude: 0.0, longitude: 0.0)), stops: nil)
}
