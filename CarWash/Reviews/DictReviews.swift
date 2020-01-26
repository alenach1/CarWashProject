//
//  DictReviews.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit
//вернуть массив ревью случайное со случайным текством
extension Dictionary where Key == Int, Value == Review {
    static func generate() -> [Int: Review] {
        var output = [Int: Review]()
        output[0] = Review(human: Human(firstName: "Alena ", secondName: "Chernova"), textReview: "Довольно таки плохо")
        output[1] = Review(human: Human(firstName: "Peter ", secondName: "Nilov"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        output[2] = Review(human: Human(firstName: "Sveta ", secondName: "Nilov"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        output[3] = Review(human: Human(firstName: "Karina ", secondName: "Olegggg"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        output[4] = Review(human: Human(firstName: "Peter ", secondName: "Nilov"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        output[5] = Review(human: Human(firstName: "Peter ", secondName: "Nilov"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        output[6] = Review(human: Human(firstName: "Peter ", secondName: "Nilov"), textReview: "Очень красиво, если бы мы значи что это такое, мы не знаем что это такое.")
        return output
    }
}
