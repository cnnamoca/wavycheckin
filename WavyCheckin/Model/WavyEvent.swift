//
//  GuestName.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-22.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

struct WavyEvent {
    
    let name: String!
    let key: String!
    let date: String!
    let eventImageURL: String!
    let guests: [DataSnapshot]!    
    
}
