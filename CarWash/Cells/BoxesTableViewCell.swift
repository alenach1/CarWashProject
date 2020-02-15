//
//  BoxesTableViewCell.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class BoxesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var numberBoxesLabel: UILabel!
    
    
    @IBOutlet weak var numberCarLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(boxes: Box) {
        var text = ""
        if boxes.car.count == 1 {
            text = "машина"
        } else if boxes.car.count == 2 || boxes.car.count == 3 || boxes.car.count == 4 {
            text = "машины"
        } else {
            text = "машин"
        }
           
        numberBoxesLabel.text = String("\(boxes.numberBox) бокс")
        numberCarLabel.text = String("\(boxes.car.count) \(text)" )
        
    }
    
}
