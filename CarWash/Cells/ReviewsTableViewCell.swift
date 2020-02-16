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
        setupLayout()
    }

    func configure(review: Review) {
        humanPhoto = review.photoHuman
        nameHumanLabel.text = review.human.allName
        reviewTextView.text = review.textReview
    }
    
    fileprivate func setupLayout() {
        
        self.backgroundColor = .systemBackground
        
    }
}
