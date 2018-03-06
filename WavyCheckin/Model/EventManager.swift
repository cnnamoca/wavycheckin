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
        
    Database.database().reference().child("WavyEvents").child(event.name).setValue(eventDict)
    }
    
    class func loadEvents() -> [WavyEvent]{
        
        var eventsArr = [WavyEvent]()
        Database.database().reference().child("WavyEvents").observe(.value) { (snapshot) in
            
            guard let value = snapshot.value as? NSDictionary else {
                print("ERROR READING EVENTS")
                return}
            
            for any in (value.allValues) {
                
                let event: [String : Any] = any as! Dictionary <String, Any>
                let eventName = event["eventNameKey"] as! String
                let eventDate = event["eventDateKey"] as! String
                let eventKey = event["idKey"] as! String
                
                let readEvent = WavyEvent(name: eventName, key: eventKey, date: eventDate, guests: nil, itemRef: nil)
                
                eventsArr.append(readEvent)
            }
            
        }
        return eventsArr
    }
}
