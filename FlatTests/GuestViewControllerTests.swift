//
//  GuestViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/15/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class GuestViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: GuestViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupGuestViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupGuestViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "GuestViewController") as? GuestViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testViewController() {
        XCTAssertNotNil(sut.view)
    }

    func testSegues() {
        let identifiers = TestsHelper.segues(ofViewController: sut)
        XCTAssertEqual(identifiers.count, 2, "Segue count should equal two.")
        XCTAssertTrue(identifiers.contains("segueGuestToSubmitRequest"),
                      "Segue segueGuestToSubmitRequest should exist.")
        XCTAssertTrue(identifiers.contains("segueGuestToHome"), "Segue segueGuestToHome should exist.")
    }
}
