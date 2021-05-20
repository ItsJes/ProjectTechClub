//
//  Home.swift
//  Tech Club
//
//  Created by Jessica Sendejo on 5/10/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class Home: UITableViewController {
    
    var userName: String!
    var currentUserImageUrl: String!
   // var currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserdata()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(signOut))
    }

    // MARK: - Table view data source
    
    func getUserdata(){
        let uid = KeychainWrapper.standard.string(forKey: "uid")
                Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
                    if let postDict = snapshot.value as? [String : AnyObject] {
                        self.userName = (postDict["username"] as! String)
                        self.tableView.reloadData()
                    }
                }
    }
                                


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ShareSomethingCell") as? ShareSomethingCell{
                if currentUserImageUrl != nil {
                    cell.configCell(userImgUrl: currentUserImageUrl)
                    cell.shareBtn.addTarget(self, action: #selector(toCreatePost), for: .touchUpInside)
                }
                return cell
                
            }
        }
        return UITableViewCell()
    }
    
    @objc func signOut(_ sender: AnyObject){
        KeychainWrapper.standard.removeObject(forKey: "uid")
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
        dismiss(animated: true, completion: nil)
       // performSegue(withIdentifier: "mainMenu", sender: nil)
    }
    
    @objc func toCreatePost (_ sender: AnyObject) {
            performSegue(withIdentifier: "toCreatePost", sender: nil)
        }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
