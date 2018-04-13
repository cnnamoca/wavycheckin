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
            "idKey": event.key,
            "imageURL": event.eventImageURL
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
                let eventImageURL = event["imageURL"] as! String
                
                let readEvent = WavyEvent(name: eventName, key: eventKey, date: eventDate, eventImageURL: eventImageURL, guests: nil)
                
                AppData.sharedInstance.eventsArr.append(readEvent)
            }
            
            AppData.sharedInstance.eventsNode.keepSynced(true)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func loadGuests(event: String) {
        AppData.sharedInstance.eventsNode.child(event).child("Guests").observe(.value, with: { (snapshot) in
            AppData.sharedInstance.eventGuests.removeAll()
            guard let value = snapshot.value as? NSDictionary else {
                return}
            
            for any in value.allValues {
                let guest: [String : Any] = any as! Dictionary <String, Any>
                let guestName = guest["guestNameKey"] as! String
                
                AppData.sharedInstance.eventGuests.append(guestName)
            }
            
            AppData.sharedInstance.eventsNode.child(event).child("Guests").keepSynced(true)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func deleteGuest(event: String, guestName: String) {
        AppData.sharedInstance.eventsNode.child(event).child("Guests").observeSingleEvent(of: .value) { (snapshot) in

            guard let value = snapshot.value as? NSDictionary else {
                return}

            for any in value.allValues{
                
                
                let guest: [String : Any] = any as! Dictionary <String, Any>
                let guestNameValue = guest["guestNameKey"] as! String
            
                if guestNameValue == guestName {
                    print(value.allKeys(for: any))
                    let keysArr = value.allKeys(for: any)
                    let string = keysArr[0] as! String
                    AppData.sharedInstance.eventsNode.child(event).child("Guests").child(string).removeValue(completionBlock: { (error, ref) in
                        if error != nil {
                            print(error?.localizedDescription as Any)
                            return
                        }
                    })
                }

            }
        }
    }
    
    class func deleteEvent(event: String) {
        AppData.sharedInstance.eventsNode.child(event).removeValue { (error, ref) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
        }
    }
    
    class func deletePhoto(eventPhoto: String) {
        AppData.sharedInstance.storageNode.child(eventPhoto).child(eventPhoto + ".png").delete { (error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
        }
    }
     
}
