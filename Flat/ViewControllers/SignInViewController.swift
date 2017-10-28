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
    
    @IBAction func loginAction(_ sender: UIButton)
    {
        if emailOutlet.text != "" && passwordOutlet.text != ""
        {
            Auth.auth().signIn(withEmail: emailOutlet.text!, password: passwordOutlet.text!, completion: { (user, error) in
                if user != nil
                {
                    //sign in successful
                    self.errorOutlet.isHidden = true
                    self.performSegue(withIdentifier: "segueSignInToHome", sender: Any?.self)
                }
                else
                {
                    self.errorOutlet.isHidden = false
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
