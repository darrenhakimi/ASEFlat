//
//  GuestPriceViewController.swift
//  Flat
//
//  Created by Valerie Dawson on 11/9/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class GuestPriceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var checkInDate: String?
    var checkOutDate: String?
    var location: String?
    var size: String?
    var price: String?

    var options = ["$1 - $100", "$101 - $200", "$201 - $300", "$301 - $400", "$401 - $500", "$501+"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]

        return cell
    }

    @objc func submitAction() {

        //var matchFound = false

        if let user = Auth.auth().currentUser {
            let ref = Constants.Refs.databaseUsers
            ref.queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                for snap in snapshot.children {
                    let hostSnap = snap as? DataSnapshot
                    let snapDict = hostSnap?.value as? [String: AnyObject]
                    let isHost = snapDict!["isHost"] as? String

                    if isHost == "true" {
                        let location = snapDict!["location"] as? String
                        let size = snapDict!["size"] as? String
                        let price = snapDict!["price"] as? String

                        if (location == self.location!) &&
                            (size == self.size!) && (price == self.price!) {
                            let hostUID = hostSnap?.key
                            //matchFound = true
                            DatabaseFunctions.guestRequest(guestUID: user.uid, hostUID: hostUID!,
                                                           checkInDate: self.checkInDate!,
                                                           checkOutDate: self.checkOutDate!)
                        }
                    }
                }
            })

            self.performSegue(withIdentifier: "segueGuestPriceToGuest", sender: Any?.self)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.price = options[indexPath.row]
        let submitButton =
            UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitAction))
        self.navigationItem.rightBarButtonItem = submitButton
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
