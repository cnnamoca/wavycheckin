//
//  AppData.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-05.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class AppData: NSObject {
    
    static let sharedInstance = AppData()
    
    public var eventsNode: DatabaseReference
    public var eventsArr = [WavyEvent]()
    public var eventGuests = [String]()
    
    public override init() {
        eventsNode = Database.database().reference().child("WavyEvents")
    }
}
