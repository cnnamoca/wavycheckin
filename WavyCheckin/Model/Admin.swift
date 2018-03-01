//
//  Admin.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-28.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation

class Admin: NSObject, NSCoding {
    
    var username: String
    var password: String
    var isLoggedIn: Bool
    var uid: String
    
    init(name: String, password: String, uid: String) {
        self.username = name
        self.password = password
        self.uid = uid
    }
    
    func encode(with aCoder: NSCoder) {
        <#code#>
    }
    
    required init?(coder aDecoder: NSCoder) {
        <#code#>
    }
}
