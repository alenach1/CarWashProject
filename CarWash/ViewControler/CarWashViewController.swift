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
    
    
    var listBoxes = [Box]()
    var dictReview : [Int : Review] = .generate() // массив
    let imageCarWash = UIImageView(image: UIImage(named: "CarWash"))
    let inageReviewers = UIImageView(image: UIImage(named: "HumanPhoto"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateBoxesInProject(boxCount: 10)
        carWashTableView.delegate = self
        carWashTableView.dataSource = self
        setupNibs()
        let hederView = InfoTableViewHeader(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 400), title: "Мойка машин")
        
        carWashTableView.tableHeaderView = hederView
        carWashTableView.tableFooterView = UIView()
        navigationItem.title = title
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
    
    func generateBoxesInProject(boxCount: Int) {
        for i in 0...boxCount {
            let generatedBox = generateCar(numberBox: i)
            listBoxes.append(generatedBox)
        }
    }
    
    func generateCar(numberBox: Int) -> Box {
        let countCar = Int.random(in:0...10)
        var carArrayRandom = [Car]()
        for elem in 0...countCar {
            let car = Car(carName: "Машина \(elem)", timeWash: Time(hour: Int.random(in: 0...23), min: Int.random(in: 0...59)))
            carArrayRandom.append(car)
        }
        
        return Box(numberBox: numberBox, car: carArrayRandom)
    }

}

extension CarWashViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.section {
            case 0:
                guard let viewControllerBoxes = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoxesViewController") as? BoxesViewController else { return }
                viewControllerBoxes.cars = getCarInBox(index: indexPath.row)
                viewControllerBoxes.numberBox = indexPath.row
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
            return 130
        default:
            return UITableView.automaticDimension
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
