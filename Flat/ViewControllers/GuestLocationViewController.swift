//
//  GuestLocationViewController.swift
//  Flat
//
//  Created by Valerie Dawson on 11/9/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class GuestLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var checkInDate: String?
    var checkOutDate: String?
    var location: String?

    var options = ["Bushwick", "Crown Heights", "Dumbo", "Flatbush", "Greenpoint", "Williamsburg"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]

        return cell
    }

    @objc func nextAction() {
        self.performSegue(withIdentifier: "segueGuestLocationToGuestSize", sender: Any?.self)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.location = options[indexPath.row]
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = nextButton
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueGuestLocationToGuestSize" {
            let guestSizeViewController = segue.destination as? GuestSizeViewController
            guestSizeViewController?.checkInDate = self.checkInDate!
            guestSizeViewController?.checkOutDate = self.checkOutDate!
            guestSizeViewController?.location = self.location!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Location"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
