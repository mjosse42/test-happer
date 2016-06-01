//
//  ratingControl.swift
//  mark1
//
//  Created by Josse on 01/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ratingControl: UIView {
    
    // MARK : properties
    
    let spacing = 5
    var ratingButtons = [UIButton]()
    let starCount = 5
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK : initialisation
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        
        var buttonFrame = CGRect(x: 5, y: 0, width: 20, height: 20)
        
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (20 + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: action du bouton
    
    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerate() {
            button.selected = index < rating
        }
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
