//
//  TestsHelper.swift
//  FlatTests
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class TestsHelper {
    //https://stackoverflow.com/questions/32470169/how-to-do-unit-test-of-segue-in-ios-9
    class func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates")
            as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}
