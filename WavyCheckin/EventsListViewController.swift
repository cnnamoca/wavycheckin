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
    
    var eventsArr = [WavyEvent]()
    var dbRef:DatabaseReference!
    var label = UILabel()
    
    @IBOutlet weak var addEventButton: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference().child("WavyEvents")
        EventsManager.loadEvents()
        
        //CHECK IF ADMIN
        if Auth.auth().currentUser == nil {
            self.addEventButton.isEnabled = false
            self.addEventButton.tintColor = .clear
            print("NO ADMIN DETECTED")
        } else {
            self.addEventButton.tintColor = .black
            print("ADMIN IS LOGGED IN")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppData.sharedInstance.eventsArr.removeAll()
    }
    
    //SETUP METHODS
    func tableViewSetup() {
        eventsArr = AppData.sharedInstance.eventsArr
        tableView.reloadData()
        
        let rect = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
        label = UILabel(frame: rect)
        tableView.addSubview(label)
        label.text = "🌊 No WAVY Events Right Now 🌊"
        label.textColor = .gray
        label.textAlignment = .center
        tableView.backgroundColor = .black
        
        if eventsArr.count > 0 {
            label.isHidden = true
        }

    }
    
    func loadEvents() {
        Database.database().reference().child("WavyEvents").observe(.value) { (snapshot) in
            
            guard let value = snapshot.value as? NSDictionary else {
                print("ERROR READING EVENTS")
                return}
            
            var newEvents = [WavyEvent]()
            for any in (value.allValues) {
                
                let event: [String : Any] = any as! Dictionary <String, Any>
                let eventName = event["eventNameKey"] as! String
                let eventDate = event["eventDateKey"] as! String
                let eventKey = event["idKey"] as! String
                
                let readEvent = WavyEvent(name: eventName, key: eventKey, date: eventDate, guests: nil, itemRef: nil)
                
                newEvents.append(readEvent)
            }
            self.eventsArr = newEvents
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Auth.auth().currentUser == nil {
            let alert = SCLAlertView()
            let txt = alert.addTextField("Guest Name")
            
            alert.addButton("Add Guest") {
                if let guestName = txt.text {
                    
                    let guestsRef = self.dbRef.child("Guests").childByAutoId()
                    guestsRef.setValue(guestName)
                }
            }
            
            
            alert.showEdit("Add Guests", subTitle: "Add Guest Names")
        } else {
            //go to guestlist edit as admin
        }
    }




}
