//
//  GuestName.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-22.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct WavyEvent {
    
    let key: String!
    let date: Date!
    let guests: [String]!
    let itemRef: DatabaseReference?
    
    init (date:Date, key:String = "") {
        self.key = key
        self.date = date
        self.itemRef = nil
    }
    
//    init(snapshot: DataSnapshot) {
//        key = snapshot.key
//        itemRef = snapshot.ref
//
//        if let dict = snapshot.value as? NSDictionary, let guestName = dict["content"] as? String{
//            content = guestName
//        }else {
//            content = ""
//        }
//
//        if let dict = snapshot.value as? NSDictionary, let wavyUser = dict["addedByUser"] as? String {
//            addedByUser = wavyUser
//        }else {
//            addedByUser = ""
//        }
//    }
}
