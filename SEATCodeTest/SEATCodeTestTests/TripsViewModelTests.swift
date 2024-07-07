//
//  TripsViewModelTests.swift
//  SEATCodeTestTests
//
//  Created by Filipe Mota on 7/7/24.
//

import XCTest
import Combine
@testable import SEATCodeTest

final class TripsViewModelTests: XCTestCase {

    func testTripsViewModelInit() {
        // Given
        
        // When
        let vm = TripsViewModel()
        
        // Then
        XCTAssertFalse(vm.showError)
        XCTAssertFalse(vm.showLoadingIndicator)
        XCTAssertEqual(vm.errorMessage, "")
        XCTAssert(vm.tripsResult.isEmpty)
        XCTAssertEqual(vm.stopInfoResult, .empty)
    }
    
    func testTripsViewModelGetTrips() {
        // Given
        let vm = TripsViewModel()
        let mockAPIClient = MockAPIClient()
        vm.apiClient = mockAPIClient
        
        // When
        vm.getTrips()
        
        // Then
        XCTAssert(vm.tripsResult.count == 1)
        XCTAssertEqual(vm.tripsResult.first?.driverName, "Mock driver")
        XCTAssertEqual(vm.tripsResult.first?.route, "Mock route")
        XCTAssertFalse(vm.showError)
    }
    
    func testTripsViewModelGetTripsWithError() {
        // Given
        let vm = TripsViewModel()
        let mockAPIClient = MockAPIClient()
        mockAPIClient.showError = true
        vm.apiClient = mockAPIClient
        
        // When
        vm.getTrips()
        
        // Then
        XCTAssertTrue(vm.tripsResult.isEmpty)
        XCTAssertTrue(vm.showError)
    }
    
    func testTripsViewModelGetStopInfo() {
        // Given
        let vm = TripsViewModel()
        let mockAPIClient = MockAPIClient()
        vm.apiClient = mockAPIClient
        
        // When
        vm.getStopInfo()
        
        // Then
        XCTAssertNotEqual(vm.stopInfoResult, .empty)
        XCTAssertEqual(vm.stopInfoResult.address, "Mock address")
        XCTAssertEqual(vm.stopInfoResult.tripId, 1)
        XCTAssertFalse(vm.showError)
    }
    
    func testTripsViewModelGetStopInfoWithError() {
        // Given
        let vm = TripsViewModel()
        let mockAPIClient = MockAPIClient()
        mockAPIClient.showError = true
        vm.apiClient = mockAPIClient
        
        // When
        vm.getStopInfo()
        
        // Then
        XCTAssertEqual(vm.stopInfoResult, .empty)
        XCTAssertTrue(vm.showError)
    }

}

extension TripsViewModelTests {
    class MockAPIClient: APIClient {
        var showError: Bool = false

        func fetchData<T>(request: URLRequest, type: T.Type) -> Future<T, URLError> where T : Decodable {
            if showError {
                return Future<T, URLError> { promise in
                    promise(.failure(URLError(.badServerResponse)))
                }
            } else {
                return Future<T, URLError> { promise in
                    if type == [TripModel].self {
                        promise(.success([TripModel.mock] as! T))
                    } else if type == StopModel.self {
                        promise(.success(StopModel.mock as! T))
                    }
                }
            }
        }
        
        
    }
}
