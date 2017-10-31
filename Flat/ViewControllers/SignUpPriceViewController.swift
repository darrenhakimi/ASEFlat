//
//  SignUpPriceViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/31/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpPriceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var price: String?
    var dataTuple: (name: String, number: String, email: String, password: String, location: String, size: String)?
    
    var options = ["$1 - $100", "$101 - $200", "$201 - $300", "$301 - $400", "$401 - $500", "$501+"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    @objc func signUpAction()
    {
        //perform host sign up
        Auth.auth().createUser(withEmail: self.dataTuple!.email, password: self.dataTuple!.password, completion: { (user, error) in
            if user != nil
            {
                DatabaseFunctions.hostSignUpRequest(user: user!, name: self.dataTuple!.name, number: self.dataTuple!.number, email: self.dataTuple!.email, location: self.dataTuple!.location, size: self.dataTuple!.size, price: self.price!)
                self.performSegue(withIdentifier: "segueSignUpPriceToHost", sender: Any?.self)
            }
            else
            {
                //sign up failed
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.price = options[indexPath.row]
        let signUpButton = UIBarButtonItem(title: "Sign up", style: .plain, target: self, action: #selector(signUpAction))
        self.navigationItem.rightBarButtonItem = signUpButton
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
