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
    }
    
    //add shake gesture to add login
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIView.animate(withDuration: 2,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.loginButton.isHidden = false
            },
                           completion: nil)
        }
    }
    
    
}

