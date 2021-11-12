//
//  FriendsTableViewCell.swift
//  Homework
//
//  Created by Пользователь on 08.02.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendAvatar: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

