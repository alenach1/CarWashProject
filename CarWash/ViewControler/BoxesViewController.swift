//
//  NavigationBoxesViewController.swift
//  CarWash
//
//  Created by alena on 25.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class BoxesViewController: UIViewController {
    
    var cars = [Car]()
    var numberBox = 0

    @IBOutlet weak var boxesCarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(numberBox) бокс"
        boxesCarTableView.delegate = self
        boxesCarTableView.dataSource = self
        setupNibs() 
        boxesCarTableView.tableFooterView = UIView()
    }

}
extension BoxesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boxesCarTableView.dequeueReusableCell(withIdentifier: ConfigurationCell.inBoxTableViewCell, for: indexPath) as! InBoxTableViewCell
        cell.configure(car: cars[indexPath.row])
        return cell
    }
}

extension BoxesViewController {
    func setupNibs() {
        let nib = UINib(nibName: NibName.inBoxTableViewCell, bundle: nil)
        boxesCarTableView.register(nib, forCellReuseIdentifier: ConfigurationCell.inBoxTableViewCell)
    }
}
