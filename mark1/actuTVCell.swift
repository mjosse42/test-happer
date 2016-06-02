//
//  actuTVCell.swift
//  mark1
//
//  Created by Josse on 02/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class actuTVCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var rating: ratingControl!
    @IBOutlet weak var outfit: UILabel!
    @IBOutlet weak var nbLike: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
