//
//  SignUpPriceViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class SignUpPriceViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: SignUpPriceViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSignUpPriceViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupSignUpPriceViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SignUpPriceViewController")
            as? SignUpPriceViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testViewController() {
        XCTAssertNotNil(sut.view)
    }

    func testOptions() {
        XCTAssertTrue(sut.options.count > 0)
    }

    func testSegues() {
        let identifiers = TestsHelper.segues(ofViewController: sut)
        XCTAssertEqual(identifiers.count, 1, "Segue count should equal one.")
        XCTAssertTrue(identifiers.contains("segueSignUpPriceToHost"), "Segue segueSignUpPriceToHost should exist.")
    }
}
