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

protocol GuestsDelegate {
    func loadGuests(event: String)
}

class EventsListsViewController: UITableViewController, EventsDelegate {
    
    var eventsArr = [WavyEvent]()
    var label = UILabel()
    var wavyCell = WavyCellTableViewCell()
    var eventName = String()
    var delegate: GuestsDelegate?
    
    @IBOutlet weak var addEventButton: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        
        addRefresh()
        
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
        setupData()
        didFinishUpdates()
    }
    
    //SETUP METHODS
    func setupData() {
        DispatchQueue.main.async {
            
            self.eventsArr = AppData.sharedInstance.eventsArr
            self.tableView.reloadData()
            
            let rect = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height)
            self.label = UILabel(frame: rect)
            self.tableView.addSubview(self.label)
            self.label.text = "🌊 No WAVY Events Right Now 🌊"
            self.label.textColor = .gray
            self.label.textAlignment = .center
            
            
            if self.eventsArr.count > 0 {
                self.label.isHidden = true
            }
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func didFinishUpdates() {
        DispatchQueue.main.async {
            self.eventsArr = AppData.sharedInstance.eventsArr
            self.tableView.reloadData()
            if self.eventsArr.count > 0 {
                self.label.isHidden = true
            }
        }
    }
    
    private func addRefresh() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = .purple
        refreshControl.addTarget(self, action: #selector(refreshEvents(_:)), for: .valueChanged)
    }
    
    @objc private func refreshEvents(_ sender: Any) {
        didFinishUpdates()
        refreshControl?.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? AddEventPopUpViewController {
            nav.delegate = self as EventsDelegate
        }
        
        if let guestVC = segue.destination as? GuestlistTableViewController {
            self.delegate = guestVC
            self.delegate?.loadGuests(event: eventName)
        }
        
    }
    
    //TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! WavyCellTableViewCell
        cell.eventNameLabel.text = eventsArr[indexPath.row].name
        cell.dateLabel.text = eventsArr[indexPath.row].date
        
        let wavyEvent = eventsArr[indexPath.row]
        if let eventImageURL = wavyEvent.eventImageURL {
            let url = URL(string: eventImageURL)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    cell.backgroundImageView.image = UIImage(named: "wavygray")
                    return
                }
              
                DispatchQueue.main.async {
                    cell.backgroundImageView.image = UIImage(data: data!)
                }
            }).resume()
            
        }
        
        cell.backgroundImageView.clipsToBounds = true
        cell.backgroundImageView.contentMode = .scaleAspectFill
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
                    let guestDict: [String : Any] = [
                        "guestNameKey":guestName
                    ]
                    
                    let cell = tableView.cellForRow(at: indexPath) as! WavyCellTableViewCell
                    AppData.sharedInstance.eventsNode.child(cell.eventNameLabel.text!).child("Guests").childByAutoId().setValue(guestDict)
                }
            }
            
            alert.showEdit("Add Guests", subTitle: "Add Guest Names")
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! WavyCellTableViewCell
            self.eventName = cell.eventNameLabel.text!
            performSegue(withIdentifier: "ToGuestlist", sender: indexPath.row)
        }
    }
    
}
