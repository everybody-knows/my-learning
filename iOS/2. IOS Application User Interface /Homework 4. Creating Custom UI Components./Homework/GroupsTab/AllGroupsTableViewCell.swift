//
//  AllGroupsTableViewCell.swift
//  Homework
//
//  Created by Пользователь on 09.02.2021.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var allGroupName: UILabel!
    @IBOutlet weak var allGroupAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
