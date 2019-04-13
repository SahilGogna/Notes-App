//
//  LoginViewController.swift
//  messagingapp
//
//  Created by Sahil Gogna on 2019-04-08.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


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
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firebase refrence
        ref = Database.database().reference()
        
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
        guard let email = emailTextField.text, let pass = passwordTextField.text else{
            print("Email or Password Missing!")
            return
        }
        //check if it is register or SignIn
        if isSignIn{
            handleSignIn(email: email, pass: pass)
        }else{
                // register the user with the firebase
            handleRegistration(email: email, pass: pass)
            }
        
    }
    
    func handleSignIn(email:String, pass:String){
        //signIn the user with the firebase
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error != nil{
                print(error!)
                return
            }
            //Successfully signed In
            self.performSegue(withIdentifier: "goToDashboard", sender: self)
        }
    }
    
    func handleRegistration(email:String, pass:String){
        guard let fName = firstNameTextField.text, let lName = lastNameTextField.text else{
            print("Missing First Name or Last Name")
            return
        }
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error != nil{
                print(error!)
                return
            }
            guard let uId = Auth.auth().currentUser?.uid else{
                return
            }
            // Dictionary to save the user values in database
            let values = ["first_name":fName,
                          "last_name":lName,
                          "email": email]
            //User is authenticated
            self.ref?.child("users").child(uId).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error!)
                    return
                }
            })
            //user is registered , go to home screen
            self.performSegue(withIdentifier: "goToDashboard", sender: self)
        }
    }
    
}
