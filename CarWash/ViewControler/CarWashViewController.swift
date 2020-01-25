//
//  ViewController.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class CarWashViewController: UIViewController {
    
    @IBOutlet weak var carWashTableView: UITableView!
    
    @IBOutlet weak var InfoTableViewHeader: InfoTableViewHeader!
    
    var listBoxes = [Box(numberBox: 1,
                         car: [Car(car: "Lada", timeWash: Time(hour: 12, min: 20)),
                               Car(car: "Renault", timeWash: Time(hour: 12, min: 50)),
                               Car(car: "Jaguar", timeWash: Time(hour: 16, min: 55)),
                               Car(car: "Jaguar", timeWash: Time(hour: 16, min: 55))]),
                     Box(numberBox: 2,
                         car: [Car(car: "Lada", timeWash: Time(hour: 11, min: 34)),
                               Car(car: "Tayota", timeWash: Time(hour: 12, min: 34)),
                               Car(car: "Lada", timeWash: Time(hour: 12, min: 20))]),
                    Box(numberBox: 3,
                        car: [Car(car: "Lada", timeWash: Time(hour: 11, min: 34)),
                              Car(car: "Tayota", timeWash: Time(hour: 12, min: 34)),
                              Car(car: "Lada", timeWash: Time(hour: 12, min: 20))]),
                    Box(numberBox: 4,
                        car: [Car(car: "Lada", timeWash: Time(hour: 11, min: 34)),
                              Car(car: "Tayota", timeWash: Time(hour: 12, min: 34))])]
    
    var dictReview : [Int : Review] = .generate()
    let imageCarWash = UIImageView(image: UIImage(named: "CarWash"))
    let inageReviewers = UIImageView(image: UIImage(named: "HumanPhoto"))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carWashTableView.delegate = self
        carWashTableView.dataSource = self
        setupNibs()
        let hederView = UIView()
        hederView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        carWashTableView.tableHeaderView = hederView
        
    }
    func getCarInBox(index: Int) -> Array<Car>{
        var carsArrayInBox = [Car]()
        for elem in listBoxes {
            if elem.numberBox == index {
                carsArrayInBox = elem.car
            }
        }
        return carsArrayInBox
        
    }

}

extension CarWashViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.section {
            case 0:
                guard let viewControllerBoxes = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoxesViewController") as? BoxesViewController else { return }
                viewControllerBoxes.cars = getCarInBox(index: indexPath.row)
                viewControllerBoxes.numberBox = indexPath.row + 1
                self.navigationController?.pushViewController(viewControllerBoxes, animated: true)
    
            default:
                break
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 100
        default:
            return UITableView.automaticDimension
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return listBoxes.count
        case 1:
            return dictReview.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
        let cell = carWashTableView.dequeueReusableCell(withIdentifier: ConfigurationCell.boxesTableViewCell, for: indexPath) as! BoxesTableViewCell
        cell.configure(numberBoxes: listBoxes[indexPath.row].numberBox, numberCar: listBoxes[indexPath.row].car.count)
           return cell
            
       case 1:
        let cell = carWashTableView.dequeueReusableCell(withIdentifier: ConfigurationCell.reviewsTableViewCell, for: indexPath) as! ReviewsTableViewCell
        cell.configure(photo: inageReviewers, nameHuman: dictReview[indexPath.row]?.human.allName ?? "Имя", review: dictReview[indexPath.row]?.textReview ?? "Отзыв")
           return cell
            
       default:
        return UITableViewCell()
       }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Все боксы"
        case 1:
            return "Отзывы"
        default:
            return ""
        }
    }
}

extension CarWashViewController {
    func setupNibs() {
        
        let nib = UINib(nibName: NibName.boxesTableViewCell, bundle: nil)
        carWashTableView.register(nib, forCellReuseIdentifier: ConfigurationCell.boxesTableViewCell)
        
        let nib1 = UINib(nibName: NibName.reviewsTableViewCell, bundle: nil)
        carWashTableView.register(nib1, forCellReuseIdentifier: ConfigurationCell.reviewsTableViewCell)
    }
}
