//
//  HomeViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 10/26/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        print("VIEWWILLAPPEAR")
        let user = Auth.auth().currentUser
        
        if (user == nil)
        {
            print("should perform segue")
            performSegue(withIdentifier: "segueHomeToSignIn", sender: Any?.self)
            self.performSegue(withIdentifier: "segueHomeToSignIn", sender: self)
        }
        else
        {
            print("USER IS VALID!!!")
            print(user!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

