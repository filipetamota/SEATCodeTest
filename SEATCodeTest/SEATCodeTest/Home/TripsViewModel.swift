//
//  TripsViewModel.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI
import Combine
import CoreLocation

struct TripsModel: Decodable {
    let trips: [TripModel]
}

struct TripModel: Decodable {
    let driverName: String
    let status: TripStatus
    let route: String
    let startTime: String
    let endTime: String
    let description: String
    let origin: Location
    let destination: Location
    
    struct Location: Decodable {
        let address: String
        let point: Coordinates
    }

    struct Stop: Decodable {
        let id: Int
        let point: Coordinates
    }

    struct Coordinates: Decodable {
        let _latitude: Double
        let _longitude: Double
    }

    enum TripStatus: Decodable {
        case ongoing
        case scheduled
        case cancelled
        case finalized
    }
}

final class TripsViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var tripResults: TripsModel = TripsModel(trips: [])
    @Published var showLoadingIndicator: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    public var apiClient: APIClient = AppAPIClient()
    
    init() {
        getTrips()
    }
    
    func getTrips() {
        showLoadingIndicator.toggle()
        guard let request = Utils.buildURLRequest(requestData: .trips) else {
            showError.toggle()
            errorMessage = NSLocalizedString("error_url_request", comment: "")
            showLoadingIndicator.toggle()
            return
        }
        apiClient.fetchData(request: request, type: TripsModel.self)
            .sink { [weak self ] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError.toggle()
                    self?.errorMessage = error.localizedDescription
                    self?.showLoadingIndicator.toggle()
                    break
                }
            } receiveValue: { [weak self ] response in
                self?.tripResults = response
                self?.showLoadingIndicator.toggle()
            }
            .store(in: &cancellables)
    }
}
