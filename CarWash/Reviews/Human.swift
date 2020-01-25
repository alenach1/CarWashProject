//
//  Human.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class Human {
    
    var firstName: String
    var secondName: String
    var allName: String
    
    init(firstName: String, secondName: String){
        self.firstName = firstName
        self.secondName = secondName
        allName = firstName + " " + secondName
    }
}
