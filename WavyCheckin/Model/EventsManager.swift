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
    
    //var delegate: EventsDelegate?
    
    class func saveEvent(event: WavyEvent) {
        
        let eventDict: [String:Any] = [
            "eventNameKey": event.name,
            "eventDateKey": event.date,
            "idKey": event.key
        ]
        
        AppData.sharedInstance.eventsNode.child(event.name).setValue(eventDict)
    }
    
    class func loadEvents() {
        AppData.sharedInstance.eventsNode.observe(.value, with: { (snapshot) in
            AppData.sharedInstance.eventsArr.removeAll()
            guard let value = snapshot.value as? NSDictionary else {
                return}
            
            for any in (value.allValues) {
                
                let event: [String : Any] = any as! Dictionary <String, Any>
                let eventName = event["eventNameKey"] as! String
                let eventDate = event["eventDateKey"] as! String
                let eventKey = event["idKey"] as! String
                
                let readEvent = WavyEvent(name: eventName, key: eventKey, date: eventDate, guests: nil, itemRef: nil)
                
                AppData.sharedInstance.eventsArr.append(readEvent)
            }
            
            AppData.sharedInstance.eventsNode.keepSynced(true)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func loadGuests(event: String) {
        AppData.sharedInstance.eventsNode.child(event).child("Guests").observe(.value, with: { (snapshot) in
            
            for snap in snapshot.children.allObjects {
                let guest = snap as! DataSnapshot
                
                AppData.sharedInstance.eventGuests.append(guest)
            }
            
            AppData.sharedInstance.eventsNode.child(event).child("Guests").keepSynced(true)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
