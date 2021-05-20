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
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toggleError()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func toggleError() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
    }
    
    @IBAction func signInPress(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil 
                {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }else
                {
                    if let userId = authResult?.user.uid{
                    KeychainWrapper.standard.set(userId, forKey: "uid")
                    self.transitionToHome()
                    self.errorLabel.alpha = 0
                    }
                    
                }
                
                
            }
        }
    }
    
    func transitionToHome() {
            /*
            let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.home) as? Home
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
 
 */
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let vc: UITabBarController = storyboard.instantiateViewController(withIdentifier: "Main") as! UITabBarController
               self.present(vc, animated: true, completion: nil)

    }
}

