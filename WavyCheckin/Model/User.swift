//
//  User.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-22.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    let uid: String
    let email: String
    
    init(userData: FirebaseAuth.User) {
        uid = userData.uid
        
        if let mail = userData.providerData.first?.email {
            email = mail
        } else {
            email = ""
        }
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
