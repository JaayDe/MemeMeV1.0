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
        
        topTextField.text = "TOP"
        bottomTextfield.text = "BOTTOM"
        
        let textfields = [topTextField, bottomTextfield]
        
        for textField in textfields {
            textField?.defaultTextAttributes = memeTextAttributes
            textField?.textAlignment = .center
        }
        
    
        
    }

    // disable camera-Button, as no camera is available in Simulator
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButtonOutlet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
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
    
}

