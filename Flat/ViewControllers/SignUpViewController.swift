//
//  SignUpViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/27/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var guestHostOutlet: UISegmentedControl!

    @IBOutlet weak var nameOutlet: UITextField!

    @IBOutlet weak var numberOutlet: UITextField!

    @IBOutlet weak var emailOutlet: UITextField!

    @IBOutlet weak var passwordOutlet: UITextField!

    @IBOutlet weak var signUpOutlet: UIButton!

    @IBOutlet weak var errorOutlet: UILabel!

    @IBAction func changeGuestHostAction(_ sender: UISegmentedControl) {
        if self.guestHostOutlet.selectedSegmentIndex == 0 {
            self.signUpOutlet.titleLabel?.text = "Sign up"
        } else {
            self.signUpOutlet.titleLabel?.text = "Next"
        }
    }

    func isValidName(testStr: String) -> Bool {
        let nameRegEx = "[a-zA-Z- ']{1,16}"

        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: testStr)
    }

    func isValidNumber(testStr: String) -> Bool {
        let numberRegEx = "[0-9]{3}-[0-9]{3}-[0-9]{4}"

        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return numberTest.evaluate(with: testStr)
    }

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

    @IBAction func signUpNextAction(_ sender: UIButton) {
        if !isValidName(testStr: nameOutlet.text!) {
            self.errorOutlet.text = "Invalid name."
            self.errorOutlet.isHidden = false
        } else if !isValidNumber(testStr: numberOutlet.text!) {
            self.errorOutlet.text = "Invalid number."
            self.errorOutlet.isHidden = false
        } else if !isValidEmail(testStr: emailOutlet.text!) {
            self.errorOutlet.text = "Invalid email."
            self.errorOutlet.isHidden = false
        } else if !isValidPassword(testStr: passwordOutlet.text!) {
            self.errorOutlet.text = "Invalid password."
            self.errorOutlet.isHidden = false
        } else if self.guestHostOutlet.selectedSegmentIndex == 0 {
            self.errorOutlet.isHidden = true
            self.performSegue(withIdentifier: "segueSignUpToGuest", sender: Any?.self)
        } else {
            self.errorOutlet.isHidden = true
            self.performSegue(withIdentifier: "segueToHostSignUp", sender: Any?.self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSignUpToGuest" {
            //perform guest sign up
            Auth.auth().createUser(withEmail: emailOutlet.text!,
                                   password: passwordOutlet.text!, completion: { (user, _) in
                if user != nil {
                    DatabaseFunctions.guestSignUpRequest(user: user!, name: self.nameOutlet.text!, number:
                        self.numberOutlet.text!, email: self.emailOutlet.text!)
                } else {
                    //sign up failed
                }
            })
        } else if segue.identifier == "segueToHostSignUp" {
            let navigationViewController = segue.destination as? UINavigationController
            let signUpLocationViewController =
                navigationViewController!.viewControllers.first as? SignUpLocationViewController
            signUpLocationViewController!.name = nameOutlet.text!
            signUpLocationViewController!.number = numberOutlet.text!
            signUpLocationViewController!.email = emailOutlet.text!
            signUpLocationViewController!.password = passwordOutlet.text!
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
