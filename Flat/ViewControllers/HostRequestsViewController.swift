//
//  HostRequestsViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 11/27/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HostRequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewOutlet: UITableView!

    var options = [(dates: String, guestUID: String, hostUID: String, requestID: String)]()
    var guestUID: String?
    var hostUID: String?
    var requestID: String?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row].dates

        return cell
    }

    func getGuestInfoForHost(currentDateTime: String) {
        let ref = Constants.Refs.databaseUsers.child(guestUID!)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String: AnyObject]
            let name = snapDict!["name"] as? String
            let email = snapDict!["email"] as? String
            let number = snapDict!["number"] as? String

            DatabaseFunctions.guestInfoForHost(currentDateTime: currentDateTime, guestUID: self.guestUID!,
                                               hostUID: self.hostUID!, requestID: self.requestID!,
                                               name: name!, email: email!, number: number!)
        })
    }

    func getHostInfoForGuest(currentDateTime: String) {
        let ref = Constants.Refs.databaseUsers.child(hostUID!)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String: AnyObject]
            let name = snapDict!["name"] as? String
            let email = snapDict!["email"] as? String
            let number = snapDict!["number"] as? String

            DatabaseFunctions.hostInfoForGuest(currentDateTime: currentDateTime, guestUID: self.guestUID!,
                                               hostUID: self.hostUID!, name: name!, email: email!, number: number!)
        })
    }

    @objc func approveAction() {
        let currentDateTime = DatabaseFunctions.getDateTime()
        self.getGuestInfoForHost(currentDateTime: currentDateTime)
        self.getHostInfoForGuest(currentDateTime: currentDateTime)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guestUID = options[indexPath.row].guestUID
        hostUID = options[indexPath.row].hostUID
        requestID = options[indexPath.row].requestID

        let approveButton =
            UIBarButtonItem(title: "Approve", style: .plain, target: self, action: #selector(approveAction))
        self.navigationItem.rightBarButtonItem = approveButton
    }

    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            let ref = Constants.Refs.databaseUsers
            ref.child(user.uid).child("requests")
                .queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                for snap in snapshot.children {
                    let offerSnap = snap as? DataSnapshot
                    let offerDict = offerSnap!.value as? [String: AnyObject]
                    let checkInDate = offerDict!["checkInDate"] as? String
                    let checkOutDate = offerDict!["checkOutDate"] as? String
                    let guestUID = offerDict!["guestUID"] as? String

                    self.options.append((dates: "\(checkInDate!) - \(checkOutDate!)",
                        guestUID: guestUID!, hostUID: user.uid, requestID: offerSnap!.key))
                }
                self.tableViewOutlet.reloadData()
            })
        }
        if self.options.count == 0 {
            //segue to no requests available at the moment, check back later
        }
    }

    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Dates"

        let cancelButton =
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
