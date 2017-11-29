//
//  GuestSizeViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class GuestSizeViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: GuestSizeViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupGuestSizeViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupGuestSizeViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "GuestSizeViewController")
            as? GuestSizeViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func testOptions() {
        XCTAssertTrue(sut.options.count > 0)
    }

    func testSegues() {
        let identifiers = TestsHelper.segues(ofViewController: sut)
        XCTAssertEqual(identifiers.count, 1, "Segue count should equal one.")
        XCTAssertTrue(identifiers.contains("segueGuestSizeToGuestPrice"),
                      "Segue segueGuestSizeToGuestPrice should exist.")
    }
}
