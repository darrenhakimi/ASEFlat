//
//  SignUpLocationViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/30/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class SignUpLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selection: String?
    var dataTuple: (name: String, number: String, email: String, password: String)?
    
    var locationOptions = ["Bushwick", "Crown Heights", "Dumbo", "Flatbush", "Greenpoint", "Williamsburg"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locationOptions[indexPath.row]
        
        return cell
    }
    
    @objc func nextAction()
    {
        //DatabaseFunctions.
        
        //self.navigationController?.popViewController(animated: true)
        
        //self.performSegue(withIdentifier: <#T##String#>, sender: Any?.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = locationOptions[indexPath.row]
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = nextButton
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
