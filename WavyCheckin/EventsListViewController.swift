//
//  EventsAndListsViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-16.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class EventsAndListsViewController: UITableViewController {
    
    var dbRef:DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference().child("WavyDates")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if admin, perform segue else display alert view that will tell users to add names
        
        let alert = SCLAlertView()
        let txt = alert.addTextField("Guest Name")
        
        alert.addButton("Add Guest") {
            if let guestName = txt.text {
                let checkinRef = self.dbRef.child("Guests")
                
                checkinRef.setValue(guestName)
            }
        }
      
        
        alert.showEdit("Add Guests", subTitle: "Add Guest Names")
    
        
    }



}
