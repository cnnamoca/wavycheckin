//
//  EventsAndListsViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-16.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

class EventsAndListsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if admin, perform segue else display alert view that will tell users to add names
        
        //regular user
        let alertController = UIAlertController(title: "Add Guest", message: "Please add guest name", preferredStyle: .alert)
        
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Guest Name"
        }
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (saveAction) in
            //perform save function
        }
        alertController.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }


}
