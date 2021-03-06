//
//  GuestMatchesListViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 11/29/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class GuestMatchesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!

    var options = [(checkInDate: String, checkOutDate: String, name: String, email: String, number: String)]()
    var checkInDate: String?
    var checkOutDate: String?
    var name: String?
    var email: String?
    var number: String?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowCheckInDate = options[indexPath.row].checkInDate
        let rowCheckOutDate = options[indexPath.row].checkOutDate
        let rowName = options[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(rowCheckInDate) - \(rowCheckOutDate): \(rowName)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkInDate = options[indexPath.row].checkInDate
        checkOutDate = options[indexPath.row].checkOutDate
        name = options[indexPath.row].name
        email = options[indexPath.row].email
        number = options[indexPath.row].number

        self.performSegue(withIdentifier: "segueGuestMatchesListToGuestMatchInfo", sender: Any?.self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueGuestMatchesListToGuestMatchInfo" {
            let guestMatchInfoViewController = segue.destination as? GuestMatchInfoViewController
            guestMatchInfoViewController!.checkInDate = self.checkInDate!
            guestMatchInfoViewController!.checkOutDate = self.checkOutDate!
            guestMatchInfoViewController!.name = self.name!
            guestMatchInfoViewController!.email = self.email!
            guestMatchInfoViewController!.number = self.number!
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        options.removeAll()
        if let user = Auth.auth().currentUser {
            let ref = Constants.Refs.databaseUsers
            ref.child(user.uid).child("offers")
                .queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                    for snap in snapshot.children {
                        let offerSnap = snap as? DataSnapshot
                        let offerDict = offerSnap!.value as? [String: AnyObject]
                        let dateTime = offerDict!["dateTime"] as? String
                        let checkInDate = offerDict!["checkInDate"] as? String
                        if DatabaseFunctions.isDateValid(
                            dateString: dateTime!, checkInDateString: checkInDate!) {
                            let checkOutDate = offerDict!["checkOutDate"] as? String
                            let name = offerDict!["name"] as? String
                            let email = offerDict!["email"] as? String
                            let number = offerDict!["number"] as? String

                            self.options.append((checkInDate: checkInDate!,
                                                 checkOutDate: checkOutDate!,
                                                 name: name!, email: email!, number: number!))
                        }
                    }
                    self.tableViewOutlet.reloadData()
                })
        }
        if self.options.count == 0 {
            //segue to no requests available at the moment, check back later
        }
    }

    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Offer"

        let backButton =
            UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
