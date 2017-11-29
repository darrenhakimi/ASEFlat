//
//  SignUpViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class SignUpViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: SignUpViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSignUpViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupSignUpViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
            as? SignUpViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testNames() {
        XCTAssertTrue(sut.isValidName(testStr: "Darren"))
        XCTAssertTrue(sut.isValidName(testStr: "O'Connel"))
        XCTAssertTrue(sut.isValidName(testStr: "Mary-Jane"))
        XCTAssertTrue(sut.isValidName(testStr: "Darren Hakimi"))
        XCTAssertFalse(sut.isValidName(testStr: ""))
        XCTAssertFalse(sut.isValidName(testStr: "3"))
        XCTAssertFalse(sut.isValidName(testStr: "This Name Is Way Too Long!"))
    }

    func testNumbers() {
        XCTAssertTrue(sut.isValidNumber(testStr: "000-000-0000"))
        XCTAssertFalse(sut.isValidNumber(testStr: ""))
        XCTAssertFalse(sut.isValidNumber(testStr: "none"))
        XCTAssertFalse(sut.isValidNumber(testStr: "000-000-000"))
        XCTAssertFalse(sut.isValidNumber(testStr: "000-000-00000"))
    }

    func testEmail() {
        XCTAssertTrue(sut.isValidEmail(testStr: "darren.hakimi@columbia.edu"))
        XCTAssertFalse(sut.isValidEmail(testStr: ""))
        XCTAssertFalse(sut.isValidEmail(testStr: "none"))
        XCTAssertFalse(sut.isValidEmail(testStr: "none@"))
        XCTAssertFalse(sut.isValidEmail(testStr: "none@none"))
        XCTAssertFalse(sut.isValidEmail(testStr: "none@none."))
    }

    func testPassword() {
        XCTAssertTrue(sut.isValidPassword(testStr: "test12"))
        XCTAssertTrue(sut.isValidPassword(testStr: "testtest"))
        XCTAssertFalse(sut.isValidPassword(testStr: ""))
        XCTAssertFalse(sut.isValidPassword(testStr: "1"))
        XCTAssertFalse(sut.isValidPassword(testStr: "test"))
    }

    func testSegues() {
        let identifiers = TestsHelper.segues(ofViewController: sut)
        XCTAssertEqual(identifiers.count, 3, "Segue count should equal three.")
        XCTAssertTrue(identifiers.contains("segueSignUpToSignIn"), "Segue segueSignUpToSignIn should exist.")
        XCTAssertTrue(identifiers.contains("segueSignUpToGuest"), "Segue segueSignUpToGuest should exist.")
        XCTAssertTrue(identifiers.contains("segueToHostSignUp"), "Segue segueToHostSignUp should exist.")
    }
}
