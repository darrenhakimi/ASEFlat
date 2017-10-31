//
//  SignUpViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/27/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController
{
    @IBOutlet weak var guestHostOutlet: UISegmentedControl!
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBOutlet weak var numberOutlet: UITextField!
    
    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var signUpOutlet: UIButton!
    
    @IBAction func changeGuestHostAction(_ sender: UISegmentedControl)
    {
        if self.guestHostOutlet.selectedSegmentIndex == 0
        {
            self.signUpOutlet.titleLabel?.text = "Sign up"
        }
        else
        {
            self.signUpOutlet.titleLabel?.text = "Next"
        }
    }
    
    @IBAction func signUpNextAction(_ sender: UIButton)
    {
        if self.guestHostOutlet.selectedSegmentIndex == 0
        {
            self.performSegue(withIdentifier: "segueSignUpToGuest", sender: Any?.self)
        }
        else
        {
            self.performSegue(withIdentifier: "segueToHostSignUp", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSignUpToGuest"
        {
            //perform guest sign up
            Auth.auth().createUser(withEmail: emailOutlet.text!, password: passwordOutlet.text!, completion: { (user, error) in
                if user != nil
                {
                    DatabaseFunctions.guestSignUpRequest(user: user!, name: self.nameOutlet.text!, number: self.numberOutlet.text!, email: self.emailOutlet.text!)
                }
                else
                {
                    //sign up failed
                }
            })
        }
        else if segue.identifier == "segueToHostSignUp"
        {
            let navigationViewController = segue.destination as! UINavigationController
            let signUpLocationViewController = navigationViewController.viewControllers.first as! SignUpLocationViewController
            signUpLocationViewController.dataTuple = (name: nameOutlet.text!, number: numberOutlet.text!, email: emailOutlet.text!, password: passwordOutlet.text!)
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
