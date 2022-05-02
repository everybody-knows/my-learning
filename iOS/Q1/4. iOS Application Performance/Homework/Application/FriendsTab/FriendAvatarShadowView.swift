//
//  FriendAvatarView.swift
//  Homework
//
//  Created by Александр on 18.04.2021.
//

import UIKit

@IBDesignable class FriendAvatarShadowView: UIView {
    
    @IBInspectable var shadowColor: UIColor?
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3)
    @IBInspectable var shadowOpacity: Float = 0.7
    @IBInspectable var shadowRadius: CGFloat = 4.0
    
    override func layoutSubviews() {
                
        // add the shadow to the base view
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.shadowColor = shadowColor!.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius

    }

}
