//
//  FlatUITests.swift
//  FlatUITests
//
//  Created by Darren Hakimi on 12/11/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest

class FlatUITests: XCTestCase {

    var app: XCUIApplication!
    var checkInDate: String?
    var checkOutDate: String?

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup
        //will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation
        //- required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testALogin() {
        let enterFlatButton = app.buttons["Enter Flat"]
        enterFlatButton.tap()

        let loginButton = app.buttons["Login"]
        loginButton.tap()
        XCTAssertTrue(app.staticTexts["Invalid email."].exists)

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("g@g.com")
        app.staticTexts["Need to sign up?"].tap()
        loginButton.tap()
        XCTAssertTrue(app.staticTexts["Invalid password."].exists)

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("1234567")
        app.staticTexts["Need to sign up?"].tap()
        loginButton.tap()
        XCTAssertTrue(app.staticTexts["Invalid username/password."].exists)

        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456")
        app.staticTexts["Need to sign up?"].tap()
        loginButton.tap()
    }

    func testBGuestSubmitRequest() {
        let enterFlatButton = app.buttons["Enter Flat"]
        enterFlatButton.tap()

        let submitRequestButton = app.buttons["Submit Request"]
        submitRequestButton.tap()

        let selectDatesNavigationBar = app.navigationBars["Select Dates"]
        selectDatesNavigationBar.buttons["Cancel"].tap()
        submitRequestButton.tap()

        let enterCheckInDateTextField = app.textFields["Enter Check-in Date"]
        enterCheckInDateTextField.tap()

        let doneButton = app.toolbars.buttons["Done"]
        doneButton.tap()

        let nextButton = selectDatesNavigationBar.buttons["Next"]
        nextButton.tap()

        let enterCheckOutDateTextField = app.textFields["Enter Check-out Date"]
        enterCheckOutDateTextField.tap()

        doneButton.tap()
        nextButton.tap()

        let tablesQuery = app.tables
        tablesQuery.staticTexts["Bushwick"].tap()
        app.navigationBars["Select Location"].buttons["Next"].tap()
        tablesQuery.staticTexts["1 Person"].tap()
        app.navigationBars["Select Size"].buttons["Next"].tap()
        tablesQuery.staticTexts["$1 - $100"].tap()
        app.navigationBars["Select Price"].buttons["Submit"].tap()
        app.buttons["Sign out"].tap()
    }

    func testCHostLogin() {
        let enterFlatButton = app.buttons["Enter Flat"]
        enterFlatButton.tap()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("h@h.com")
        app.staticTexts["Need to sign up?"].tap()

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456")
        app.staticTexts["Need to sign up?"].tap()

        let loginButton = app.buttons["Login"]
        loginButton.tap()
    }

    func testDApproveRequest() {
        let enterFlatButton = app.buttons["Enter Flat"]
        enterFlatButton.tap()

        app.buttons["Requests"].tap()

        let tablesQuery = app.tables
        tablesQuery.cells.element(boundBy: 0).tap()

        let selectDatesNavigationBar = app.navigationBars["Select Dates"]
        let approveButton = selectDatesNavigationBar.buttons["Approve"]
        approveButton.tap()
        selectDatesNavigationBar.buttons["Cancel"].tap()
        app.buttons["Matches"].tap()
        tablesQuery.cells.element(boundBy: 0).tap()
        app.navigationBars["Guest Info"].buttons["Select Offer"].tap()
        app.navigationBars["Select Offer"].buttons["Cancel"].tap()
        app.buttons["Sign out"].tap()
    }

    func testEGuestLogin() {
        let enterFlatButton = app.buttons["Enter Flat"]
        enterFlatButton.tap()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("g@g.com")
        app.staticTexts["Need to sign up?"].tap()

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456")
        app.staticTexts["Need to sign up?"].tap()

        let loginButton = app.buttons["Login"]
        loginButton.tap()
    }

    func testFGuestApprovals() {
        let enterFlatButton = app.buttons["Enter Flat"]
        enterFlatButton.tap()

        let matchesButton = app.buttons["Matches"]
        matchesButton.tap()

        let tablesQuery = app.tables
        tablesQuery.cells.element(boundBy: 0).tap()

        app.navigationBars["Host Info"].buttons["Select Offer"].tap()
        app.navigationBars["Select Offer"].buttons["Back"].tap()
        app.buttons["Sign out"].tap()
    }

}
