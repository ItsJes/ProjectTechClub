//
//  ViewController.swift
//  Tech Club
//
//  Created by Jessica Sendejo on 3/28/21.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }
    
    override func viewDidAppear(_ animated: Bool) {
        if KeychainWrapper.standard.string(forKey: "uid") != nil{
            self.performSegue(withIdentifier: "toHome", sender: nil)
        }
    }
    
    @IBAction func signInPress(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil 
                {
                    //create account
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                      // ...
                    }
                }
                else{
                    if let userId = authResult?.user.uid{
                    KeychainWrapper.standard.set(userId, forKey: "uid")
                    //self.performSegue(withIdentifier: "toHome", sender: nil)
                    }
                    
                }
            }
        }
    }
    
}

