//
//  GuestDateViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/16/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class GuestDateViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: GuestDateViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupGuestDateViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupGuestDateViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "GuestDateViewController")
            as? GuestDateViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func areDatesValid() {
        let currentDate = Date()
        let oneYearTime: TimeInterval = 365 * 24 * 60 * 60

        sut.checkInDateOutlet.text = ""
        sut.checkOutDateOutlet.text = ""
        XCTAssertFalse(sut.areDatesValid()) //check-in date is ""

        sut.checkInDateOutlet.text = "\(currentDate.addingTimeInterval(oneYearTime))"
        XCTAssertFalse(sut.areDatesValid()) //check-out date is ""

        sut.checkOutDateOutlet.text = "\(currentDate)"
        XCTAssertFalse(sut.areDatesValid()) //check-in date > check-out date

        sut.checkInDateOutlet.text = "\(currentDate)"
        sut.checkOutDateOutlet.text = "\(currentDate.addingTimeInterval(oneYearTime))"
        XCTAssertTrue(sut.areDatesValid())
    }

    func testSegues() {
        let identifiers = TestsHelper.segues(ofViewController: sut)
        XCTAssertEqual(identifiers.count, 1, "Segue count should equal one.")
        XCTAssertTrue(identifiers.contains("segueGuestDateToGuestLocation"),
                      "Segue segueGuestDateToGuestLocation should exist.")
    }

}
