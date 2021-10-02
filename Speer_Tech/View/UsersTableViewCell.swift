//
//  UsersTableViewCell.swift
//  Speer_Tech
//
//  Created by Ravi Kanth Bollam on 2021-10-01.
//

import UIKit
import SDWebImage

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var users: Items! {
        didSet{
            nameLbl.text = users.username
            imgView.sd_setImage(with: URL(string: users.imageUrl))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
