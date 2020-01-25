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

    func configure(numberBoxes: Int, numberCar: Int) {
        var text = ""
        if numberCar == 1 {
            text = "машина"
        } else if numberCar == 2 || numberCar == 3 || numberCar == 4 {
            text = "машины"
        } else {
            text = "машин"
        }
           
        numberBoxesLabel.text = String("\(numberBoxes) бокс")
        numberCarLabel.text = String("\(numberCar) \(text)" )
        
    }
    
}
