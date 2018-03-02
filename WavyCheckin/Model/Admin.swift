//
//  Admin.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-28.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Admin{
    
    var username: String
    var password: String
    var uid: String
    
    init(userData: User) {
        uid = userData.uid
        
        if let mail = userData.providerData
    }
}
