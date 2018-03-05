//
//  AddEventPopUpViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-01.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

class AddEventPopUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        popUpView.layer.cornerRadius = 10
        textField.placeholder = "Enter Event Name"
        saveButton.isEnabled = false
        textField.delegate = self
        
        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        //EDIT DATE INTO STRING
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: datePicker.date)
        let wavyEvent = WavyEvent.init(name: textField.text, key: textField.text! + "|" + datePicker.date.description, date: dateStr, guests: nil, itemRef: nil)
        EventsManager.saveEvent(event: wavyEvent)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if (textField.text?.isEmpty)! {
//            self.saveButton.isEnabled = false
//        }
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            self.saveButton.isEnabled = false
        } else {
            self.saveButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
