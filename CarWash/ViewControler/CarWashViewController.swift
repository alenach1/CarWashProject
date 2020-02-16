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
    var listReview = [Review]()
    let imageCarWash = UIImageView(image: UIImage(named: "CarWash"))
    let imageReviewers = UIImageView(image: UIImage(named: "HumanPhoto"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRewiew()
        generateBoxesInProject()
        carWashTableView.delegate = self
        carWashTableView.dataSource = self
        setupNibs()
        let hederView = InfoTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400), title: "Мойка машин")
        
        carWashTableView.tableHeaderView = hederView
        carWashTableView.tableFooterView = UIView()
        navigationItem.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carWashTableView.reloadData()
    }
    
   
    
    func generateBoxesInProject() {
        for i in 0...Int.random(in:0...10) {
            let generatedBox = generateCar(numberBox: i)
            listBoxes.append(generatedBox)
        }
    }
    
    func generateRewiew() -> Array<Review> {
        let rewiewCount = Int.random(in:0...10)
        let humanArr = [Human(firstName: "Igor", secondName: "Borisov"),
                        Human(firstName: "Leonid", secondName: "Teplov"),
                        Human(firstName: "Anna", secondName: "Barsuk"),
                        Human(firstName: "Igor", secondName: "Litvinov")]

        let textReviewArr = ["Очень круто","Сложно сказать, ни разу не был на этой мойке","Рекомендую друзьям и коллегам","Если бы мог сказать, но я не могу говорить","Отмыли меня и машину, спасибо Олегу Петровичу"]
        
        for elem in 0...rewiewCount {
            let review = Review(human: humanArr[Int.random(in:0...(humanArr.count - 1))], textReview: textReviewArr[Int.random(in:0...(textReviewArr.count - 1))], photoHuman: imageReviewers)
            listReview.append(review)
        }
        return listReview
    }
    
    func generateCar(numberBox: Int) -> Box {
        let countCar = Int.random(in:0...10)
        var carArrayRandom = [Car]()
        for elem in 0...countCar {
            
            let car = Car(carName: "Машина \(elem)", timeWash: (generateRandomDate(daysForvard: 100)!))
            carArrayRandom.append(car)
        }
        
        return Box(numberBox: numberBox, car: carArrayRandom)
    }
    
    func generateRandomDate(daysForvard: Int)-> String?{
        let day = arc4random_uniform(UInt32(daysForvard))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = 1 * Int(day + 1)
        offsetComponents.hour = 1 * Int(hour)
        offsetComponents.minute = 1 * Int(minute)
        
        guard let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) ) else { return "11 sept" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return formatter.string(from: randomDate)
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
               return listReview.count
           default:
               return 0
           }
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
        let cell = carWashTableView.dequeueReusableCell(withIdentifier: ConfigurationCell.boxesTableViewCell, for: indexPath) as! BoxesTableViewCell
        cell.configure(boxes: listBoxes[indexPath.row])
           return cell
            
       case 1:
        let cell = carWashTableView.dequeueReusableCell(withIdentifier: ConfigurationCell.reviewsTableViewCell, for: indexPath) as! ReviewsTableViewCell
        cell.configure(review: listReview[indexPath.row])
           return cell
            
       default:
        return UITableViewCell()
       }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.section {
            case 0:
                guard let viewControllerBoxes = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoxesViewController") as? BoxesViewController else { return }
                viewControllerBoxes.box = listBoxes[indexPath.row]
                viewControllerBoxes.numberBox = indexPath.row
                self.navigationController?.pushViewController(viewControllerBoxes, animated: true)
            case 1:
                let editController = EditComentViewController(review: listReview[indexPath.row])
                editController.delegate = self
                self.present(editController, animated: true, completion: nil)
                
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

extension CarWashViewController: EditReviewDelegate {
    func editViewControllerDidShow() {
        print("Show edit controller")
    }
    
    func editViewControllerDidDisapear() {
        print("hide edit controller")
    }
    
    func editViewControllerDidSave(review: Review) {
        print(review.textReview)
        carWashTableView.reloadData()
        
    }
}


