//
//  SignUpLocationViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/30/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class SignUpLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var location: String?
    var dataTuple: (name: String, number: String, email: String, password: String)?
    
    var options = ["Bushwick", "Crown Heights", "Dumbo", "Flatbush", "Greenpoint", "Williamsburg"]
    
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
        self.performSegue(withIdentifier: "segueSignUpLocationToSignUpSize", sender: Any?.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.location = options[indexPath.row]
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueSignUpLocationToSignUpSize"
        {
            let signUpSizeViewController = segue.destination as! SignUpSizeViewController
            signUpSizeViewController.dataTuple = (name: self.dataTuple!.name, number: self.dataTuple!.number, email: self.dataTuple!.email, password: self.dataTuple!.password, location: self.location!)
        }
    }
    
    @objc func cancelAction()
    {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Location"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
