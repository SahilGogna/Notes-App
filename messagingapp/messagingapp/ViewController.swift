//
//  ViewController.swift
//  messagingapp
//
//  Created by Sahil Gogna on 2019-04-05.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var postData = [String]()
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    var databaseHandle: DatabaseHandle?
    
    var depArray = [Department]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //set the firebase refrence
        ref = Database.database().reference()
        
        //Retreive the posts and listen for the changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            // code to execute when a child is added under "Posts", this code is fiored for each child in the Posts
            // convert value to String
            let post = snapshot.value as? String
            if let postDataNew = post{
                // snapshot contains key value pairs, append in array
                self.postData.append(postDataNew)
                
                //reloading tableview
                self.tableView.reloadData()
            }
            
        })
//        guard let key = ref?.child("Departments").childByAutoId().key else { return }
//        let department = ["emp_id": "33",
//                              "id": "1234",
//                        "location": "Test Location",
//                       "long_desc": "This is a long desc which is updated",
//                            "name": "Updated Name",
//                    "phone_number": "1234512345",
//                      "short_desc": "This is a short updated desc"
//        ]
//    }


}

    @IBAction func logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "signinpage", sender: self)
        }catch{
            print("Error while signing out!")
        }
    }
}
