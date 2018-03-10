//
//  ViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-02-12.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var addGuestButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isHidden = true
        loginButton.isEnabled = false
        addGuestButton.layer.cornerRadius = addGuestButton.frame.height / 2
    }
    
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
    
    @IBAction func loginAction(_ sender: UIButton) {
        let alert = SCLAlertView()
        let emailtxt = alert.addTextField("email")
        let passtxt = alert.addTextField("password")
        
        alert.addButton("Login") {
            guard let _ = emailtxt.text, let _ = passtxt.text else {
                SCLAlertView().showError("Whoops!", subTitle: "Please Fill Out All Required Fields")
                return
            }
            
            Auth.auth().signIn(withEmail: emailtxt.text!,
                                        password: passtxt.text!,
                                        completion: { (user, err) in
                                            if (err == nil) {
//                                                let curUser = Auth.auth().currentUser
                                                
                                                print("LOGIN SUCCESSFUL")
                                            } else {
                                                SCLAlertView().showError("Whoops!", subTitle: "Your email or password was filled in incorrectly ")
                                            }
            })
        }
        
        alert.showEdit("Admin Login", subTitle: "Please Enter Credentials")
            
    }
    
    
    
}

