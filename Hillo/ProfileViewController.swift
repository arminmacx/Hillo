//
//  ProfileViewController.swift
//  Hillo
//
//  Created by Armin on 8/12/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageUploadButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    
    var userUid: String!
    var userName: String!
    let imagePicker = UIImagePickerController()
    var name: String!
    var uploadingImage: Data!
    var loggedInUser: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        locationText.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        usernameLabel.alpha = 0
        userLocationLabel.alpha = 0
        loggedInUser = Auth.auth().currentUser
        
        //add live text input to labels
        usernameTextField.addTarget(self, action: #selector(usernameEndEditing), for: UIControlEvents.editingChanged)
        locationText.addTarget(self, action: #selector(locationTextEndEditing), for: UIControlEvents.editingChanged)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImage.image = pickedImage
            self.uploadingImage = UIImageJPEGRepresentation(pickedImage, 0.6)
        }
    }//ImagePicker Func
    
    
    @IBAction func selectImageProfile(_ sender: UIButton) {
        let optionSelect = UIAlertController(title: nil, message: "Upload photo from", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (action:UIAlertAction) -> Void in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let cameraSelect = UIAlertAction(title: "Camera", style: .default, handler: {
            (action:UIAlertAction) -> Void in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        optionSelect.addAction(cancelAction)
        optionSelect.addAction(photoLibrary)
        optionSelect.addAction(cameraSelect)
        
        present(optionSelect, animated: true, completion: nil)
    }//AlertAction Sheet Func for picking image source
    
    @IBAction func doneButtonClicked() {
        if usernameTextField.text == "" {
            showAlretMessage("Oooops", messge: "Username should be set")
        } else {
            UploadImage.Instance.sendMedia(image: self.uploadingImage, progress: self.progressView) { (success) in
                if (success) {
                    self.performSegue(withIdentifier: "main", sender: nil)
                    self.view.removeFromSuperview()
                } else {
                    return
                }
            }
        }
    }
    
    
    //add did ending action for textfield
    @IBAction func usernameEndEditing(_ sender: UITextField) {
        usernameLabel.text = usernameTextField.text
        UIView.animate(withDuration: 1, animations: {
            self.usernameLabel.alpha = 1
            self.usernameLabel.textColor = UIColor.white
            
        })
    }
    
    @IBAction func locationTextEndEditing(_ sender: UITextField) {
        userLocationLabel.text = locationText.text
        UIView.animate(withDuration: 1, animations: {
            self.userLocationLabel.alpha = 1
            self.userLocationLabel.textColor = UIColor.white
            
        })
    }
    
    func showAlretMessage(_ title: String, messge: String) {
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainViewController {
            destination.userSelectedImageForUpload = self.profileImage.image
            destination.userNameText = self.usernameTextField.text
        }
    }
    
}
