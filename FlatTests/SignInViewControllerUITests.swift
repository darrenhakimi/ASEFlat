//
//  SignInViewControllerUITest.swift
//  FlatTests
//
//  Created by Darren Hakimi on 12/9/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest

class SignInViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        super.tearDown()
    }

    func myTestExample() {
        app.buttons["Enter Flat"].tap()
    }

}
