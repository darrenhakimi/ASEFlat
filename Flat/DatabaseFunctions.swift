//
//  DatabaseFunctions.swift
//  Flat
//
//  Created by Darren Hakimi on 10/31/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import Foundation
import Firebase

class DatabaseFunctions {
    class func getDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy, HH:mm:ssZZZZZ"
        return formatter.string(from: Date())
    }

    class func guestSignUpRequest(user: User, name: String, number: String, email: String) {
        let currentDateTime = getDateTime()

        let usersRef = Constants.Refs.databaseUsers.child("\(user.uid)")
        let values = ["dateTime": currentDateTime, "name": name, "number": number, "email": email,
                      "isHost": "false"] as [String: Any]
        usersRef.updateChildValues(values)
    }
    class func hostSignUpRequest(user: User, name: String, number: String,
                                 email: String, location: String, size: String, price: String) {
        let currentDateTime = getDateTime()

        let usersRef = Constants.Refs.databaseUsers.child("\(user.uid)")
        let values = ["dateTime": currentDateTime, "name": name, "number": number, "email": email,
                      "isHost": "true", "location": location, "size": size, "price": price] as [String: Any]
        usersRef.updateChildValues(values)
    }

    class func guestRequest(guestUID: String, hostUID: String, checkInDate: String,
                            checkOutDate: String, location: String, size: String, price: String) {
        let currentDateTime = getDateTime()

        let usersRef = Constants.Refs.databaseUsers.child(hostUID).child("requests").childByAutoId()
        let values = ["dateTime": currentDateTime, "guestUID": guestUID, "checkInDate": checkInDate,
                      "checkOutDate": checkOutDate, "location": location, "size": size, "price": price] as [String: Any]
        usersRef.updateChildValues(values)
    }

    class func guestInfoForHost(currentDateTime: String, guestUID: String, hostUID: String,
                                requestID: String, name: String, email: String, number: String) {
        let usersRef = Constants.Refs.databaseUsers.child(hostUID).child("requests").child(requestID)
        let values = ["dateTime": currentDateTime, "guestUID": guestUID, "name": name,
                      "email": email, "number": number] as [String: Any]
        usersRef.updateChildValues(values)
    }

    class func hostInfoForGuest(currentDateTime: String, guestUID: String, hostUID: String,
                                name: String, email: String, number: String) {
        let usersRef = Constants.Refs.databaseUsers.child(guestUID).child("offers").childByAutoId()
        let values = ["dateTime": currentDateTime, "hostUID": hostUID, "name": name,
                      "email": email, "number": number] as [String: Any]
        usersRef.updateChildValues(values)
    }
}
