//
//  GuestlistTableViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-09.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

class GuestlistTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
