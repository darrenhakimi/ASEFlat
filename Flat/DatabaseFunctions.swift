//
//  DatabaseFunctions.swift
//  Flat
//
//  Created by Darren Hakimi on 10/31/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import Foundation
import Firebase

class DatabaseFunctions
{
    class func getDateTime() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy, HH:mm:ssZZZZZ"
        return formatter.string(from: Date())
    }
    
    class func guestSignUpRequest(user: User, name: String, number: String, email: String)
    {
        let currentDateTime = getDateTime()
        
        let usersRef = Constants.refs.databaseUsers.child("\(user.uid)")
        let values = ["dateTime": currentDateTime, "name": name, "number": number, "email": email, "isHost": "false"] as [String : Any]
        usersRef.updateChildValues(values)
    }
    class func hostSignUpRequest(user: User, name: String, number: String, email: String, location: String, size: String, price: String)
    {
        let currentDateTime = getDateTime()
        
        let usersRef = Constants.refs.databaseUsers.child("\(user.uid)")
        let values = ["dateTime": currentDateTime, "name": name, "number": number, "email": email, "isHost": "true", "location": location, "size": size, "price": price] as [String : Any]
        usersRef.updateChildValues(values)
    }
}
