//
//  NewsTableViewCustomCell.swift
//  Homework
//
//  Created by Александр on 19.11.2021.
//

import UIKit

class NewsTableViewCustomCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var heartButton: HeartButton!
    
    @IBAction func heartButtonPressed(_ sender: Any) {
        if self.heartButton.filled {
            self.heartButton.filled = false
        } else {
            self.heartButton.filled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
