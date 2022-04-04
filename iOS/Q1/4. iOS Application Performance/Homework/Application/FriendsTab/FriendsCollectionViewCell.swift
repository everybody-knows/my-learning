//
//  FriendsCollectionViewCell.swift
//  Homework
//
//  Created by Александр on 12.03.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var heartCount: UILabel!
    @IBOutlet weak var heartButton: HeartButton!
    
    func animateHeartCount(toText: String){
        UIView.transition(with: heartCount,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: {
            self.heartCount.text = toText
        })
    }
    
    @IBAction func heartButtonPressed(_ sender: HeartButton) {
        if self.heartButton.filled {
            self.heartButton.filled = false
            //self.heartCount.text = "0"
            animateHeartCount(toText: "0")
        } else {
            self.heartButton.filled = true
            //self.heartCount.text = "1"
            animateHeartCount(toText: "1")
        }
    }
}
