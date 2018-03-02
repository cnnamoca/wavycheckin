//
//  EventManager.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-01.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import Foundation
import Firebase

class EventsManager: NSObject {
    
    var events = [WavyEvent]()
    
    class func saveEvent(event: WavyEvent) {
        
        let eventDict: [String:Any] = [
            "eventNameKey": event.name,
            "eventDateKey": event.date,
            "idKey": event.key
        ]
        
        Database.database().reference().child(event.name).setValue(eventDict)
    }
    
    class func readEvents() {
        Database.database().reference().child("Events").observe(.value) { (snapshot) in
            
            guard let value = snapshot.value as? NSDictionary else {
                print("ERROR READING VALUE")
                return}
            
            for _ in (value.allValues) {
                
            }
            
            
            
            
        }
    }
}
