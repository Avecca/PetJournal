//
//  RoundedButton.swift
//  PetJournal
//
//  Created by Hanna Astlind on 2019-11-14.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {

    
    //Or use Key Path
    //layer.cornerRadius     Number     5
    
    //Choosen in inspector
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    func updateCornerRadius() {
        clipsToBounds = true
        layer.cornerRadius =  rounded ? frame.size.height / 2 : 0
        
        
        //layer.cornerRadius = cornerRadius
        
        
    }

}
