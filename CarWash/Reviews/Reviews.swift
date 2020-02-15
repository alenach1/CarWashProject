//
//  Reviews.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class Review {
    
    var human: Human
    var photoHuman: UIImageView
    var textReview: String
    
    init(human: Human, textReview: String, photoHuman: UIImageView) {
        self.human = human
        self.textReview = textReview
        self.photoHuman = UIImageView(image: UIImage(named: "HumanPhoto"))
    }
}
