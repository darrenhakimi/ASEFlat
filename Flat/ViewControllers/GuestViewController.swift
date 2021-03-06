//
//  GuestViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 11/14/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class GuestViewController: UIViewController {
    @IBAction func signOutAction(_ sender: UIButton) {
        try? Auth.auth().signOut()

        performSegue(withIdentifier: "segueGuestToHome", sender: Any?.self)
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
