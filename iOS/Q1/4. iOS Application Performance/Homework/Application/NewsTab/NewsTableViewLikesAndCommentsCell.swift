//
//  NewsTableViewLikesAndCommentsCell.swift
//  Homework
//
//  Created by Александр on 06.04.2022.
//

import UIKit

class NewsTableViewLikesAndCommentsCell: UITableViewCell {

    @IBOutlet weak var newsLikesButton: HeartButton!
    @IBOutlet weak var newsLikesCount: UILabel!
    @IBOutlet weak var newsCommentsButton: UIButton!
    @IBOutlet weak var newsCommentsCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func newsLikesButtonPressed(_ sender: HeartButton) {
        if self.newsLikesButton.filled {
            self.newsLikesButton.filled = false
        } else {
            self.newsLikesButton.filled = true
        }
    }
        
}
