//
//  ViewController.swift
//  MemeMeV1
//
//  Created by Johannes Dierkes on 02.05.17.
//  Copyright © 2017 Johannes Dierkes. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    
    @IBOutlet var allViews: UIView!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    
    let memeTextAttributes:[String:Any] = [NSStrokeColorAttributeName: UIColor.black, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: "3.0"]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottomTextfield.delegate = self
        
        initialSetup()
        
        let textfields = [topTextField, bottomTextfield]
        
        for textField in textfields {
            textField?.defaultTextAttributes = memeTextAttributes
            textField?.textAlignment = .center
        }
        
        shareButtonOutlet.isEnabled = false
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // disable camera-Button, as no camera is available in Simulator
        cameraButtonOutlet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // code to move view Up when bottom TextField is selected
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // code to move view down when bottom TextField is deselected
        unsubscribeToKeyboardNotifications()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let image = self.generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            activity, completed, items, error in
            self.save()
            self.initialSetup()
            self.dismiss(animated: true, completion: nil)
        }
        
        present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        initialSetup()
        
    }

    @IBAction func cameraButton(_ sender: Any) {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    @IBAction func albumButton(_ sender: Any) {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .photoLibrary
        
        self.present(albumPicker, animated: true, completion: nil)
    }
    
    // assign selected image to PictureView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            pictureView.image = image
        }
        
        shareButtonOutlet.isEnabled = true
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // editing of textfields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    // hide keyboard if return button pressed in one of the textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Code to move pictureView up, when Keyboard is shown for bottom TextField
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextfield.isFirstResponder {
            allViews.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if bottomTextfield.isFirstResponder {
            allViews.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
 
    // generate Memed Image
    func generateMemedImage() -> UIImage {
        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.allViews.frame.size)
        allViews.drawHierarchy(in: self.allViews.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
        
        return memedImage
    }
    
    func initialSetup() {
        topTextField.text = "TOP"
        bottomTextfield.text = "BOTTOM"
        pictureView.image = nil
    }
    
    // save meme
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextfield.text!, originalImage: pictureView.image!, memedImage: generateMemedImage())
    }
}


