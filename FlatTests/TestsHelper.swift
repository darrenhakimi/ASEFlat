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

    //https://stackoverflow.com/questions/18699524/is-it-possible-to-test-ibaction
    class func checkActionForButton
        (_ button: UIButton?, actionName: String, event: UIControlEvents = UIControlEvents.touchUpInside,
         target: UIViewController) -> Bool {

        if let unwrappedButton = button, let actions =
            unwrappedButton.actions(forTarget: target, forControlEvent: event) {

            var testAction = actionName
            if let trimmedActionName = actionName.components(separatedBy: ":").first {
                testAction = trimmedActionName
            }

            return (!actions.filter { $0.contains(testAction) }.isEmpty)
        }

        return false
    }
}
