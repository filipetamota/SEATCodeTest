//
//  FormViewUITests.swift
//  SEATCodeTestUITests
//
//  Created by Filipe Mota on 7/7/24.
//

import XCTest

final class FormViewUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }

    func test_FormView_form_shouldOpenForm() throws {
        // GIVEN
        let navBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        // WHEN
        let formButton = navBar.buttons["FormButton"]
        XCTAssertTrue(formButton.waitForExistence(timeout: 5))
        formButton.tap()
        
        // THEN
        let navBarTitle = navBar.staticTexts["Report an Issue"]
        XCTAssertTrue(navBarTitle.waitForExistence(timeout: 5))
    }
    
    // TODO: Disable Hardware keyboard on the simulator before running test
    func test_FormView_form_shouldAddIssue() throws {
        // GIVEN
        let navBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        openFormView(navBar: navBar)
        
        // WHEN
        let firstNameTextField = app.collectionViews.textFields["First name (mandatory)"]
        let lastNameTextField = app.collectionViews.textFields["Last name (mandatory)"]
        let emailNameTextField = app.collectionViews.textFields["E-mail (mandatory)"]
        let issueTextEditor = app.collectionViews.textViews["IssueTextEditor"]
        
        XCTAssertTrue(firstNameTextField.waitForExistence(timeout: 5))
        firstNameTextField.tap()
        
        let fKey = app.keys["F"]
        XCTAssertTrue(fKey.waitForExistence(timeout: 5))
        fKey.tap()
        
        XCTAssertTrue(lastNameTextField.waitForExistence(timeout: 5))
        lastNameTextField.tap()
        
        let lKey = app.keys["L"]
        XCTAssertTrue(lKey.waitForExistence(timeout: 5))
        lKey.tap()
        
        XCTAssertTrue(emailNameTextField.waitForExistence(timeout: 5))
        emailNameTextField.tap()
        
        let eKey = app.keys["E"]
        XCTAssertTrue(eKey.waitForExistence(timeout: 5))
        eKey.tap()
        
        let aKey = app.keys["@"]
        XCTAssertTrue(aKey.waitForExistence(timeout: 5))
        aKey.tap()
        
        let gKey = app.keys["g"]
        XCTAssertTrue(gKey.waitForExistence(timeout: 5))
        gKey.tap()
        
        let pKey = app.keys["."]
        XCTAssertTrue(pKey.waitForExistence(timeout: 5))
        pKey.tap()
        
        let cKey = app.keys["c"]
        XCTAssertTrue(cKey.waitForExistence(timeout: 5))
        cKey.tap()
        
        let oKey = app.keys["o"]
        XCTAssertTrue(oKey.waitForExistence(timeout: 5))
        oKey.tap()
        
        let mKey = app.keys["m"]
        XCTAssertTrue(mKey.waitForExistence(timeout: 5))
        mKey.tap()
        let returnKey = app.buttons["Return"]
        XCTAssertTrue(returnKey.waitForExistence(timeout: 5))
        returnKey.tap()
        
        XCTAssertTrue(issueTextEditor.waitForExistence(timeout: 5))
        issueTextEditor.tap()
        
        let iKey = app.keys["I"]
        iKey.tap()
        
        let saveButton = navBar.staticTexts["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
        
        // Then
        let alert = app.alerts["Issue"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        let alertMessage = alert.staticTexts["Issue reported!"]
        XCTAssertTrue(alertMessage.waitForExistence(timeout: 5))
    }
    
    // TODO: Disable Hardware keyboard on the simulator before running test
    func test_FormView_form_shouldGiveErrorAddingIssueFirstNameMissing() throws {
        // GIVEN
        let navBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        openFormView(navBar: navBar)
        
        // WHEN
        let lastNameTextField = app.collectionViews.textFields["Last name (mandatory)"]
        let emailNameTextField = app.collectionViews.textFields["E-mail (mandatory)"]
        let issueTextEditor = app.collectionViews.textViews["IssueTextEditor"]
        
        XCTAssertTrue(lastNameTextField.waitForExistence(timeout: 5))
        lastNameTextField.tap()
        
        let lKey = app.keys["L"]
        XCTAssertTrue(lKey.waitForExistence(timeout: 5))
        lKey.tap()
        
        XCTAssertTrue(emailNameTextField.waitForExistence(timeout: 5))
        emailNameTextField.tap()
        
        let eKey = app.keys["E"]
        XCTAssertTrue(eKey.waitForExistence(timeout: 5))
        eKey.tap()
        
        let aKey = app.keys["@"]
        XCTAssertTrue(aKey.waitForExistence(timeout: 5))
        aKey.tap()
        
        let gKey = app.keys["g"]
        XCTAssertTrue(gKey.waitForExistence(timeout: 5))
        gKey.tap()
        
        let pKey = app.keys["."]
        XCTAssertTrue(pKey.waitForExistence(timeout: 5))
        pKey.tap()
        
        let cKey = app.keys["c"]
        XCTAssertTrue(cKey.waitForExistence(timeout: 5))
        cKey.tap()
        
        let oKey = app.keys["o"]
        XCTAssertTrue(oKey.waitForExistence(timeout: 5))
        oKey.tap()
        
        let mKey = app.keys["m"]
        XCTAssertTrue(mKey.waitForExistence(timeout: 5))
        mKey.tap()
        let returnKey = app.buttons["Return"]
        XCTAssertTrue(returnKey.waitForExistence(timeout: 5))
        returnKey.tap()
        
        XCTAssertTrue(issueTextEditor.waitForExistence(timeout: 5))
        issueTextEditor.tap()
        
        let iKey = app.keys["I"]
        iKey.tap()
        
        let saveButton = navBar.staticTexts["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
        
        // Then
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        let alertMessage = alert.staticTexts["Error reporting issue"]
        XCTAssertTrue(alertMessage.waitForExistence(timeout: 5))
    }
    
    // TODO: Disable Hardware keyboard on the simulator before running test
    func test_FormView_form_shouldGiveErrorAddingIssueInvalidEmail() throws {
        // GIVEN
        let navBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        openFormView(navBar: navBar)
        
        // WHEN
        let firstNameTextField = app.collectionViews.textFields["First name (mandatory)"]
        let lastNameTextField = app.collectionViews.textFields["Last name (mandatory)"]
        let emailNameTextField = app.collectionViews.textFields["E-mail (mandatory)"]
        let issueTextEditor = app.collectionViews.textViews["IssueTextEditor"]
        
        XCTAssertTrue(firstNameTextField.waitForExistence(timeout: 5))
        firstNameTextField.tap()
        
        let fKey = app.keys["F"]
        XCTAssertTrue(fKey.waitForExistence(timeout: 5))
        fKey.tap()
        
        XCTAssertTrue(lastNameTextField.waitForExistence(timeout: 5))
        lastNameTextField.tap()
        
        let lKey = app.keys["L"]
        XCTAssertTrue(lKey.waitForExistence(timeout: 5))
        lKey.tap()
        
        XCTAssertTrue(emailNameTextField.waitForExistence(timeout: 5))
        emailNameTextField.tap()
        
        let eKey = app.keys["E"]
        XCTAssertTrue(eKey.waitForExistence(timeout: 5))
        eKey.tap()
        
        let aKey = app.keys["@"]
        XCTAssertTrue(aKey.waitForExistence(timeout: 5))
        aKey.tap()
        
        let gKey = app.keys["g"]
        XCTAssertTrue(gKey.waitForExistence(timeout: 5))
        gKey.tap()
        
        let cKey = app.keys["c"]
        XCTAssertTrue(cKey.waitForExistence(timeout: 5))
        cKey.tap()
        
        let oKey = app.keys["o"]
        XCTAssertTrue(oKey.waitForExistence(timeout: 5))
        oKey.tap()
        
        let mKey = app.keys["m"]
        XCTAssertTrue(mKey.waitForExistence(timeout: 5))
        mKey.tap()
        let returnKey = app.buttons["Return"]
        XCTAssertTrue(returnKey.waitForExistence(timeout: 5))
        returnKey.tap()
        
        XCTAssertTrue(issueTextEditor.waitForExistence(timeout: 5))
        issueTextEditor.tap()
        
        let iKey = app.keys["I"]
        iKey.tap()
        
        let saveButton = navBar.staticTexts["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
        
        // Then
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        let alertMessage = alert.staticTexts["Error reporting issue"]
        XCTAssertTrue(alertMessage.waitForExistence(timeout: 5))
    }
    
    // TODO: Disable Hardware keyboard on the simulator before running test
    func test_FormView_form_shouldGiveErrorAddingIssueInvalidPhone() throws {
        // GIVEN
        let navBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        openFormView(navBar: navBar)
        
        // WHEN
        let firstNameTextField = app.collectionViews.textFields["First name (mandatory)"]
        let lastNameTextField = app.collectionViews.textFields["Last name (mandatory)"]
        let emailNameTextField = app.collectionViews.textFields["E-mail (mandatory)"]
        let phoneNameTextField = app.collectionViews.textFields["Telefone number (optional)"]
        let issueTextEditor = app.collectionViews.textViews["IssueTextEditor"]
        
        XCTAssertTrue(firstNameTextField.waitForExistence(timeout: 5))
        firstNameTextField.tap()
        
        let fKey = app.keys["F"]
        XCTAssertTrue(fKey.waitForExistence(timeout: 5))
        fKey.tap()
        
        XCTAssertTrue(lastNameTextField.waitForExistence(timeout: 5))
        lastNameTextField.tap()
        
        let lKey = app.keys["L"]
        XCTAssertTrue(lKey.waitForExistence(timeout: 5))
        lKey.tap()
        
        XCTAssertTrue(phoneNameTextField.waitForExistence(timeout: 5))
        phoneNameTextField.tap()
        
        let zKey = app.keys["0"]
        XCTAssertTrue(zKey.waitForExistence(timeout: 5))
        zKey.tap()
        
        XCTAssertTrue(emailNameTextField.waitForExistence(timeout: 5))
        emailNameTextField.tap()
        
        let eKey = app.keys["E"]
        XCTAssertTrue(eKey.waitForExistence(timeout: 5))
        eKey.tap()
        
        let aKey = app.keys["@"]
        XCTAssertTrue(aKey.waitForExistence(timeout: 5))
        aKey.tap()
        
        let gKey = app.keys["g"]
        XCTAssertTrue(gKey.waitForExistence(timeout: 5))
        gKey.tap()
        
        let pKey = app.keys["."]
        XCTAssertTrue(pKey.waitForExistence(timeout: 5))
        pKey.tap()
        
        let cKey = app.keys["c"]
        XCTAssertTrue(cKey.waitForExistence(timeout: 5))
        cKey.tap()
        
        let oKey = app.keys["o"]
        XCTAssertTrue(oKey.waitForExistence(timeout: 5))
        oKey.tap()
        
        let mKey = app.keys["m"]
        XCTAssertTrue(mKey.waitForExistence(timeout: 5))
        mKey.tap()
        
        let returnKey = app.buttons["Return"]
        XCTAssertTrue(returnKey.waitForExistence(timeout: 5))
        returnKey.tap()
        
        XCTAssertTrue(issueTextEditor.waitForExistence(timeout: 5))
        issueTextEditor.tap()
        
        let iKey = app.keys["I"]
        iKey.tap()
        
        let saveButton = navBar.staticTexts["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
        
        // Then
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        let alertMessage = alert.staticTexts["Error reporting issue"]
        XCTAssertTrue(alertMessage.waitForExistence(timeout: 5))
    }
}

extension XCTestCase {
    func openFormView(navBar: XCUIElement) {
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))

        let formButton = navBar.buttons["FormButton"]
        XCTAssertTrue(formButton.waitForExistence(timeout: 5))
        formButton.tap()

        let navBarTitle = navBar.staticTexts["Report an Issue"]
        XCTAssertTrue(navBarTitle.waitForExistence(timeout: 5))
    }
}

