//
//  ViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-12.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var addGuestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isHidden = true
        loginButton.isEnabled = false
        //addGuestButton.layer.cornerRadius = addGuestButton.frame.width / 2
    }
    
    //add shake gesture to add login
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.loginButton.isHidden = false
                            self.loginButton.isEnabled = true
            },
                           completion: nil)
        }
    }
    
    //add alert view for admin login
    @IBAction func loginAction(_ sender: UIButton) {
        //
    }
    
    
    
}

