//
//  SignUpSizeViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/31/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class SignUpSizeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var size: String?
    var dataTuple: (name: String, number: String, email: String, password: String, location: String)?
    
    var options = ["1 Person", "2 Person", "3 Person", "4 Person", "5+ Person"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    @objc func nextAction()
    {
        self.performSegue(withIdentifier: "segueSignUpSizeToSignUpPrice", sender: Any?.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.size = options[indexPath.row]
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSignUpSizeToSignUpPrice"
        {
            let signUpPriceViewController = segue.destination as? SignUpPriceViewController
            signUpPriceViewController!.dataTuple =
                (name: self.dataTuple!.name, number: self.dataTuple!.number,
                 email: self.dataTuple!.email, password: self.dataTuple!.password,
                 location: self.dataTuple!.location, self.size!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Size"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
