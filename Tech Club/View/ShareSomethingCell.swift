//
//  ShareSomethingCell.swift
//  Tech Club
//
//  Creat/Users/itsjes/Desktop/Project Tech Club/Tech Club/Tech Club/View/ShareSomethingCell.swifted by Jessica Sendejo on 5/10/21.
//

import UIKit
import Firebase

class ShareSomethingCell: UITableViewCell {
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(userImgUrl: String) {
           let httpsReference = Storage.storage().reference(forURL: userImgUrl)
           
           httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error == nil {
                   // Uh-oh, an error occurred!
               } else {
                   // Data for "images/island.jpg" is returned
                   let image = UIImage(data: data!)
                   self.userImgView.image = image
               }
           }
       }
    

}
