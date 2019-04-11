//
//  LoginViewController.swift
//  messagingapp
//
//  Created by Sahil Gogna on 2019-04-08.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var isSignIn: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide fname and lname fields when view intitally loads
        firstNameLabel.isHidden = true
        firstNameTextField.isHidden = true
        lastNameLabel.isHidden = true
        lastNameTextField.isHidden = true

    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        //flip the boolean
        isSignIn = !isSignIn
        
        //change the label
        if isSignIn{
            //hide fname and lname fields
            firstNameLabel.isHidden = true
            firstNameTextField.isHidden = true
            lastNameLabel.isHidden = true
            lastNameTextField.isHidden = true
            
            signInLabel.text = "SignIn"
            signInButton.setTitle("SignIn", for: .normal)
            
        }else{
            //show fname and lname fields when user taps register
            firstNameLabel.isHidden = false
            firstNameTextField.isHidden = false
            lastNameLabel.isHidden = false
            lastNameTextField.isHidden = false
            
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        //TODO: Do some form validation on the email and the password
        
        if let email = emailTextField.text, let pass = passwordTextField.text{
            //check if it is register or SignIn
            if isSignIn{
                //signIn the user with the firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    // check if the user is not null
                    if let u = user{
                        //user is found , go to home screen
                        self.performSegue(withIdentifier: "goToDashboard", sender: self)
                    }else{
                        //Error: check error and show message
                        print("\(error)")
                    }
                }
            }else{
                // register the user with the firebase
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    // check if the user is not null
                    if let u = user{
                        let userId = Auth.auth().currentUser?.uid
                        print("\(userId) %%%%%%%%%%%%%%")
                        
                        //user is found , go to home screen
                        self.performSegue(withIdentifier: "goToDashboard", sender: self)
                        
                    }else{
                        //Error: check error and show message
                        print("\(error)")
                    }
                }
                
            }
        }
    }
}
