//
//  TripsViewModel.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI
import Combine

final class TripsViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var tripsResult: [TripModel] = []
    @Published private(set) var stopInfoResult: StopModel = .empty
    @Published var showLoadingIndicator: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    public var apiClient: APIClient = AppAPIClient()
    
    func getTrips() {
        showLoadingIndicator.toggle()
        guard let request = Utils.buildURLRequest(requestData: .trips) else {
            showError.toggle()
            errorMessage = NSLocalizedString("error_url_request", comment: "")
            showLoadingIndicator.toggle()
            return
        }
        apiClient.fetchData(request: request, type: [TripModel].self)
            .compactMap { $0 }
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
                self?.tripsResult = response
                self?.showLoadingIndicator.toggle()
            }
            .store(in: &cancellables)
    }
    
    func getStopInfo() {
        guard let request = Utils.buildURLRequest(requestData: .stops) else {
            showError.toggle()
            errorMessage = NSLocalizedString("error_url_request", comment: "")
            return
        }
        apiClient.fetchData(request: request, type: StopModel.self)
            .compactMap { $0 }
            .sink { [weak self ] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError.toggle()
                    self?.errorMessage = error.localizedDescription
                    break
                }
            } receiveValue: { [weak self ] response in
                self?.stopInfoResult = response
            }
            .store(in: &cancellables)
    }
}
