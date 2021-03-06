//
//  SignInViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class SignInViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: SignInViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSignInViewController()
        loadView()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupSignInViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testViewController() {
        XCTAssertNotNil(sut.view)
    }

    //applied this test in UI Testing
    /*func testScheduleActionIsConnected() {
        sut.loginAction(sut.loginButtonOutlet)
        XCTAssertTrue(sut.errorOutlet.text! == "Invalid email.")

        sut.emailOutlet.text = "g@g.com"
        sut.loginAction(sut.loginButtonOutlet)
        XCTAssertTrue(sut.errorOutlet.text! == "Invalid password.")

        sut.passwordOutlet.text = "emailpasswordmismatch"
        sut.loginAction(sut.loginButtonOutlet)
        waitForExpectations(timeout: 3) { (_) in
            XCTAssertTrue(self.sut.errorOutlet.text! == "Invalid username/password.")
        }

        sut.passwordOutlet.text = "123456"
        sut.loginAction(sut.loginButtonOutlet)
        waitForExpectations(timeout: 3) { (_) in
            XCTAssertTrue(self.sut.errorOutlet.isHidden)
        }
    }*/

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
        XCTAssertTrue(identifiers.contains("segueSignInToSignUp"), "Segue segueSignInToSignUp should exist.")
        XCTAssertTrue(identifiers.contains("segueSignInToGuest"), "Segue segueSignInToGuest should exist.")
        XCTAssertTrue(identifiers.contains("segueSignInToHost"), "Segue segueSignInToHost should exist.")
    }
}
