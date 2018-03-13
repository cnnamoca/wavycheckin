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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.sharedInstance.eventGuests.count
    }


}
