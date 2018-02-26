//
//  GuestName.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-22.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct WavyGuestList {
    
    let key: String!
    let content: String!
    let addedByUser: String!
    let itemRef: DatabaseReference?
    
    init (content:String, addedByUser:String, key:String = "") {
        self.key = key
        self.content = content
        self.addedByUser = addedByUser
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let dict = snapshot.value as? NSDictionary, let guestName = dict["content"] as? String{
            content = guestName
        }else {
            content = ""
        }
        
        if let dict = snapshot.value as? NSDictionary, let wavyUser = dict["addedByUser"] as? String {
            addedByUser = wavyUser
        }else {
            addedByUser = ""
        }
    }
}
