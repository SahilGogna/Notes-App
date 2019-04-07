//
//  ComposeViewController.swift
//  messagingapp
//
//  Created by Sahil Gogna on 2019-04-07.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var textBox: UITextView!
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPost(_ sender: UIButton) {
        //TODO: Post the data to firebase
        
        //Dismiss the popover
        //presentingViewController has refrence to the view controller that presented this button
        // then we need to dismiss
        
//        weak var presentingViewController = self.presentingViewController
//
//        self.dismiss(animated: true, completion: nil)
        
//        ref?.child("Posts").childByAutoId().setValue("Hello FireBase")
        ref?.child("Posts").childByAutoId().setValue(textBox.text)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deletePost(_ sender: UIButton) {
        
//        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
