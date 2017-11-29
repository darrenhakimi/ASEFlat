//
//  Constants.swift
//  Flat
//
//  Created by Darren Hakimi on 10/31/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    struct Refs {
        static let databaseRoot = Database.database().reference()
        static let databaseUsers = databaseRoot.child("users")
    }
}
