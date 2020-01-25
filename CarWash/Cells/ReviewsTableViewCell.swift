//
//  ReviewsTableViewCell.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var humanPhoto: UIImageView!
    
    @IBOutlet weak var nameHumanLabel: UILabel!
    
    @IBOutlet weak var reviewTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(photo:UIImageView, nameHuman:String, review:String) {
        humanPhoto = photo
        nameHumanLabel.text = nameHuman
        reviewTextView.text = review
    }
    
}
