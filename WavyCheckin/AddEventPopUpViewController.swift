//
//  AddEventPopUpViewController.swift
//  WavyCheckin
//
//  Created by Carlo Namoca on 2018-03-01.
//  Copyright © 2018 Carlo Namoca. All rights reserved.
//

import UIKit
import Firebase

protocol EventsDelegate {
    func didFinishUpdates()
}

class AddEventPopUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var selectedImageView: UIImageView!
    var delegate: EventsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 10
        textField.placeholder = "Enter Event Name"
        saveButton.isEnabled = false
        textField.delegate = self
        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: datePicker.date)
        
        let uploadData = UIImagePNGRepresentation(selectedImageView.image!)
        
        let eventName = textField.text!
        let storageRef = AppData.sharedInstance.storageNode.child(eventName).child(eventName + ".png")

        storageRef.putData(uploadData!, metadata: nil) { (imgMetadata, error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
            print(imgMetadata as Any)
            
            let group = DispatchGroup()
            group.enter()
            DispatchQueue.main.async {
                let wavyEvent = WavyEvent.init(name: eventName, key: eventName + "|" + self.datePicker.date.description, date: dateStr, eventImageURL: imgMetadata?.downloadURL()?.absoluteString, guests: nil)
                EventsManager.saveEvent(event: wavyEvent)
                group.leave()
            }

            group.notify(queue: .main, execute: {
                self.dismiss(animated: true, completion:  self.delegate?.didFinishUpdates)
            })
            
        }
    }
    
    @IBAction func addImageAction(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            selectedImageView.image = selectedImage
            dismiss(animated: true, completion: nil)
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
