//
//  SignInViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/27/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailOutlet: UITextField!

    @IBOutlet weak var passwordOutlet: UITextField!

    @IBOutlet weak var errorOutlet: UILabel!

    @IBOutlet weak var loginButtonOutlet: UIButton!

    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    func isValidPassword(testStr: String) -> Bool {
        if testStr.count < 6 {
            return false
        }
        return true
    }

    @IBAction func loginAction(_ sender: UIButton) {
        if !isValidEmail(testStr: emailOutlet.text!) {
            self.errorOutlet.text = "Invalid email."
            self.errorOutlet.isHidden = false
        } else if !isValidPassword(testStr: passwordOutlet.text!) {
            self.errorOutlet.text = "Invalid password."
            self.errorOutlet.isHidden = false
        } else {
            Auth.auth().signIn(withEmail: emailOutlet.text!, password: passwordOutlet.text!,
                               completion: { (user, _) in
                if user != nil {
                    //sign in successful
                    self.errorOutlet.isHidden = true

                    //determine if user is a guest or a host and segue accordingly
                    let ref = Constants.Refs.databaseUsers.child("\(user!.uid)")
                    ref.observeSingleEvent(of: .value, with: { (snapshot) in
                        let snapDict = snapshot.value as? [String: AnyObject]
                        let userType = snapDict!["isHost"] as? String

                        if userType == "false" {
                            self.performSegue(withIdentifier: "segueSignInToGuest", sender: Any?.self)
                        } else if userType == "true" {
                            self.performSegue(withIdentifier: "segueSignInToHost", sender: Any?.self)
                        }
                    })
                } else {
                    self.errorOutlet.text = "Invalid username/password."
                    self.errorOutlet.isHidden = false
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
