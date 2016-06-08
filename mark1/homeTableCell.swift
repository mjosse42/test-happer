//
//  homeTableCell.swift
//  mark1
//
//  Created by Josse on 03/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class homeTableCell: UITableViewCell {

    @IBOutlet weak var leftcontainView: UIView!
    @IBOutlet weak var rightContainView: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var outfit: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
