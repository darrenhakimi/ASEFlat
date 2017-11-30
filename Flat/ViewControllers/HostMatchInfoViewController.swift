//
//  HostMatchInfoViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 11/30/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class HostMatchInfoViewController: UIViewController {

    @IBOutlet weak var datesOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var numberOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!

    var checkInDate: String?
    var checkOutDate: String?
    var name: String?
    var email: String?
    var number: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Guest Info"

        datesOutlet.text = "\(checkInDate!) - \(checkOutDate!)"
        nameOutlet.text = "Name: \(name!)"
        emailOutlet.text = "Email: \(email!)"
        numberOutlet.text = "Number: \(number!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
