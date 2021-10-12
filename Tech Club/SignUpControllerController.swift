//
//  SignUpControllerController.swift
//  Tech Club
//
//  Created by Jessica Sendejo on 5/19/21.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpControllerController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleError()

        // Do any additional setup after loading the view.
    }
    
    func toggleError() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
            
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
    
    func validateFields() -> String? {
            
            // Check that all fields are filled in
            if usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                return "Please fill in all fields."
            }
            
            // Check if the password is secure
            let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        if SignUpControllerController.isPasswordValid(cleanedPassword) == false {
                // Password isn't secure enough
                return "Password must be at least 8 characters,\ncontains a special character,\n and a number."
            }
            
            return nil
        }

    

    @IBAction func signupPress(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            let username = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["username":username, "uid": result!.user.uid ]) { (error) in
                    if error != nil {
                        self.showError("Error saving user data")
                    }
                    self.transitionToHome()
                    self.errorLabel.alpha = 0
                }
            }
        }
    }
    
            
    func showError(_ message:String) {
                
                errorLabel.text = message
                errorLabel.alpha = 1
            }

    func transitionToHome() {
 
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let vc: UITabBarController = storyboard.instantiateViewController(withIdentifier: "Main") as! UITabBarController
               self.present(vc, animated: true, completion: nil)
    }


}

    
            
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


