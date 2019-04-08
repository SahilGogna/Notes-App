//
//  LoginViewController.swift
//  messagingapp
//
//  Created by Sahil Gogna on 2019-04-08.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
    }
}
