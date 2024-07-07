//
//  SEATCodeTestUITests.swift
//  SEATCodeTestUITests
//
//  Created by Filipe Mota on 3/7/24.
//

import XCTest

final class ContentViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }

    func test_ContentView_tripsView_shouldSelectRowAndShowRoute() {
        // GIVEN
        
        // WHEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        app.collectionViews.cells.firstMatch.tap()
        
        // THEN
        let destinationPin = app.staticTexts["D"]
        XCTAssertTrue(destinationPin.waitForExistence(timeout: 5))
    }
    
    func test_ContentView_tripsView_shouldSelectAndDeselectRow() {
        // GIVEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        app.collectionViews.cells.firstMatch.tap()
        
        // WHEN
        app.collectionViews.cells.firstMatch.tap()
        
        // THEN
        let destinationPin = app.staticTexts["D"]
        XCTAssertFalse(destinationPin.waitForExistence(timeout: 5))
    }
    
    func test_ContentView_tripsView_shouldSelectRowAndShowStopInfo() {
        // GIVEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        app.collectionViews.cells.firstMatch.tap()
        let destinationPin = app.staticTexts["D"]
        XCTAssertTrue(destinationPin.waitForExistence(timeout: 5))
        
        // WHEN
        let stopPin = app.staticTexts["S"].firstMatch
        XCTAssertTrue(stopPin.waitForExistence(timeout: 5))
        stopPin.tap()
        
        // THEN
        let addressText = app.staticTexts["Ramblas, Barcelona"]
        XCTAssertTrue(addressText.waitForExistence(timeout: 5))
        let lineText = app.staticTexts["Line 1"]
        XCTAssertTrue(lineText.waitForExistence(timeout: 5))
    }

}
