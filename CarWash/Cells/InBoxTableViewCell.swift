//
//  InBoxTableViewCell.swift
//  CarWash
//
//  Created by alena on 25.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class InBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var timeCarWashLabel: UILabel!
    
    @IBOutlet weak var carLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(car: Car) {
        carLabel.text = car.car
        timeCarWashLabel.text = car.timeWash.timeText
     }
    
}
