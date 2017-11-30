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

    class func isDateValid(dateString: String, checkInDateString: String) -> Bool {
        let expirationTime = 60.0 * 60 * 24 * 3 //3 days
        //let expirationTime = 30.0 //30 seconds

        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy, HH:mm:ssZZZZZ"

        let date = formatter.date(from: dateString)
        let checkInDate = formatter.date(from: "\(checkInDateString), 00:00:00-00:00")

        if (date!.timeIntervalSince(Date()) < expirationTime) &&
            (date!.timeIntervalSince(Date()) > (-1.0 * expirationTime)) &&
            (Date().timeIntervalSince(checkInDate!) < 0) {
            return true
        }

        return false
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
                            checkOutDate: String) {
        let currentDateTime = getDateTime()

        let usersRef = Constants.Refs.databaseUsers.child(hostUID).child("requests").childByAutoId()
        let values = ["dateTime": currentDateTime, "guestUID": guestUID, "checkInDate": checkInDate,
                      "checkOutDate": checkOutDate] as [String: Any]
        usersRef.updateChildValues(values)
    }

    class func guestInfoForHost(currentDateTime: String, guestUID: String, hostUID: String,
                                requestID: String, name: String, email: String, number: String) {
        let usersRef = Constants.Refs.databaseUsers.child(hostUID).child("requests").child(requestID)
        let values = ["dateTime": currentDateTime, "guestUID": guestUID, "isApproved": "true", "name": name,
                      "email": email, "number": number] as [String: Any]
        usersRef.updateChildValues(values)
    }

    class func hostInfoForGuest(currentDateTime: String, guestUID: String, hostUID: String, checkInDate: String,
                                checkOutDate: String, name: String, email: String, number: String) {
        let usersRef = Constants.Refs.databaseUsers.child(guestUID).child("offers").childByAutoId()
        let values = ["dateTime": currentDateTime, "hostUID": hostUID, "checkInDate": checkInDate,
                      "checkOutDate": checkOutDate, "name": name, "email": email, "number": number]
            as [String: Any]
        usersRef.updateChildValues(values)
    }
}
