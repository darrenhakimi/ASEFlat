//
//  SignUpPriceViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/31/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpPriceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var price: String?
    var name: String?
    var number: String?
    var email: String?
    var password: String?
    var location: String?
    var size: String?

    var options = ["$1 - $100", "$101 - $200", "$201 - $300", "$301 - $400", "$401 - $500", "$501+"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]

        return cell
    }

    @objc func signUpAction() {
        //perform host sign up
        Auth.auth().createUser(withEmail: self.email!, password: self.password!, completion: { (user, _) in
            if user != nil {
                DatabaseFunctions.hostSignUpRequest(user: user!, name: self.name!, number: self.number!,
                                                    email: self.email!, location: self.location!, size: self.size!,
                                                    price: self.price!)
                self.performSegue(withIdentifier: "segueSignUpPriceToHost", sender: Any?.self)
            } else {
                //sign up failed
            }
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.price = options[indexPath.row]
        let signUpButton =
            UIBarButtonItem(title: "Sign up", style: .plain, target: self, action: #selector(signUpAction))
        self.navigationItem.rightBarButtonItem = signUpButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Price"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
