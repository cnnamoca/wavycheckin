//
//  GuestlistTableViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-09.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

class GuestlistTableViewController: UITableViewController, GuestsDelegate {
    
    var selectedEvent = String()
    var guestsArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadGuests(event: selectedEvent)
    }
    
    func loadGuests(event: String) {
        DispatchQueue.main.async {
            self.selectedEvent = event
            EventsManager.loadGuests(event: self.selectedEvent)
            self.guestsArr = AppData.sharedInstance.eventGuests
            self.tableView.reloadData()
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
        loadGuests(event: selectedEvent)
        refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                let group = DispatchGroup()
                group.enter()
                
                DispatchQueue.main.async {
                    EventsManager.deleteGuest(event: self.selectedEvent, guestName: (cell.textLabel?.text)!)
                    AppData.sharedInstance.eventGuests.remove(at: indexPath.row)
                    group.leave()
                }
                
                
                group.notify(queue: .main, execute: {
                    self.loadGuests(event: self.selectedEvent)
                })
            }
            
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = guestsArr[indexPath.row].description
        cell.textLabel?.textAlignment = .center
        
        return cell
    }

}
