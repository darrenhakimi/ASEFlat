//
//  HomeViewControllerTests.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import XCTest
@testable import Flat

class HomeViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: HomeViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomeViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Tests
    func testSegues() {
        let identifiers = TestsHelper.segues(ofViewController: sut)
        XCTAssertEqual(identifiers.count, 3, "Segue count should equal three.")
        XCTAssertTrue(identifiers.contains("segueHomeToSignIn"), "Segue segueHomeToSignIn should exist.")
        XCTAssertTrue(identifiers.contains("segueHomeToGuest"), "Segue segueHomeToGuest should exist.")
        XCTAssertTrue(identifiers.contains("segueHomeToHost"), "Segue segueHomeToHost should exist.")
    }
    
}
