//
//  NewsTableViewTextCell.swift
//  Homework
//
//  Created by Александр on 06.04.2022.
//

import UIKit

class NewsTableViewTextCell: UITableViewCell {
    
    @IBOutlet weak var newsTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
