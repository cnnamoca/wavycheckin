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
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference().child("WavyDate")

    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
//        if indexPath.row%2==0{
//            cell.backgroundColor = .white
//        } else {
//            cell.backgroundColor = .gray
//        }
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
                
                let guestsRef = self.dbRef.child("Guests").childByAutoId()
                guestsRef.setValue(guestName)
            }
        }
      
        
        alert.showEdit("Add Guests", subTitle: "Add Guest Names")
    
        
    }



}
