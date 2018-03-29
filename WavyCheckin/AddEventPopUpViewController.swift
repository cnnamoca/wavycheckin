//
//  AddEventPopUpViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-01.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit

protocol EventsDelegate {
    func didFinishUpdates()
}

class AddEventPopUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var delegate: EventsDelegate?
    
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
        let wavyEvent = WavyEvent.init(name: textField.text, key: textField.text! + "|" + datePicker.date.description, date: dateStr, eventImage: nil, guests: nil)
        EventsManager.saveEvent(event: wavyEvent)
        
        DispatchQueue.main.async {
            self.delegate?.didFinishUpdates()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageAction(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.delegate?.didFinishUpdates()
        dismiss(animated: true, completion: nil)
    }
    
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
