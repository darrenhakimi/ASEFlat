//
//  HostViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/16/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class HostViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: HostViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupHostViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupHostViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "HostViewController") as? HostViewController
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
        XCTAssertEqual(identifiers.count, 1, "Segue count should equal one.")
        XCTAssertTrue(identifiers.contains("segueHostToHome"), "Segue segueHostToHome should exist.")
    }
}
