//
//  HomeViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/26/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBAction func enterFlatAction(_ sender: UIButton)
    {
        let user = Auth.auth().currentUser
        
        if (user == nil)
        {
            self.performSegue(withIdentifier: "segueHomeToSignIn", sender: Any?.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

