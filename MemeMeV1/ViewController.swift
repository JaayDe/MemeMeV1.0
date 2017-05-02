//
//  ViewController.swift
//  MemeMeV1
//
//  Created by Johannes Dierkes on 02.05.17.
//  Copyright © 2017 Johannes Dierkes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }

    @IBAction func cameraButton(_ sender: Any) {
    }
    
    @IBAction func albumButton(_ sender: Any) {
    }
    
}

