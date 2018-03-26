//
//  GuestlistTableViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-09.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

class GuestlistTableViewController: UITableViewController, GuestsDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadGuests(event: String) {
        EventsManager.loadGuests(event: event)
        tableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.sharedInstance.eventGuests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = AppData.sharedInstance.eventGuests[indexPath.row].description
        cell.textLabel?.textAlignment = .center
        
        return cell
    }


}
