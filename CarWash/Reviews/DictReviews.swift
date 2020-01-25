//
//  DictReviews.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

extension Dictionary where Key == Int, Value == Review {
    static func generate() -> [Int: Review] {
        var output = [Int: Review]()
        output[0] = Review(human: Human(firstName: "Alena ", secondName: "Chernova"), textReview: "Довольно таки плохо")
        output[1] = Review(human: Human(firstName: "Peter ", secondName: "Nilov"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        return output
    }
}
