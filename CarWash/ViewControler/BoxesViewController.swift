//
//  BoxesViewController.swift
//  CarWash
//
//  Created by alena on 25.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit
enum Mode {
    case view
    case select
}
class BoxesViewController: UIViewController {
    //peredavat suda model classa box, i menyat ego svoystvo cars, togda pri vizvrashenii na perviy ekran class izmenitsya
    var box : Box?
    var numberBox = 0
    var selectArrCar = [Car]()
    var mMode: Mode = .view{
        didSet {
            switch mMode {
            case .view:
                for (key, value) in dictionarySelect {
                    if value {
                        boxesCarTableView.deselectRow(at: key, animated: true)
                    }
                }
                dictionarySelect.removeAll()
                selectBarButton.title = "Select"
                navigationItem.leftBarButtonItem = nil
                boxesCarTableView.allowsMultipleSelection = false
            
            case .select:
                selectBarButton.title = "Cancel"
                navigationItem.leftBarButtonItem = deleteBarButton
                boxesCarTableView.allowsMultipleSelection = true
            }
        }
    }
    
    
    lazy var selectBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicker(_:)))
        return barButtonItem
    } ()
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicker(_:)))
        return barButtonItem
    } ()
    
    lazy var addBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCarButtonClicker(_:)))
        return barButtonItem
    } ()
    
    var dictionarySelect = [IndexPath : Bool]()
    

    @IBOutlet weak var boxesCarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(numberBox) бокс"
        boxesCarTableView.delegate = self
        boxesCarTableView.dataSource = self
        setupNibs()
        boxesCarTableView.tableFooterView = UIView()
        boxesCarTableView.reloadData()
        setupNavigationsBar()
        
    }

}
extension BoxesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return box?.car.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boxesCarTableView.dequeueReusableCell(withIdentifier: ConfigurationCell.inBoxTableViewCell, for: indexPath) as! InBoxTableViewCell
        cell.configure(car: (box?.car[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    
        return UITableViewCell.EditingStyle.delete
    }
}

extension BoxesViewController {
    func setupNibs() {
        let nib = UINib(nibName: NibName.inBoxTableViewCell, bundle: nil)
        boxesCarTableView.register(nib, forCellReuseIdentifier: ConfigurationCell.inBoxTableViewCell)
    }
}

extension BoxesViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch mMode {
            case .view:
                boxesCarTableView.deselectRow(at: indexPath, animated: true)
            case .select:
                dictionarySelect[indexPath] = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if mMode == .select {
            dictionarySelect[indexPath] = false
        }
    }
}

extension BoxesViewController {
    
    @objc func addCarButtonClicker(_ sender: UIBarButtonItem) {
        let addCarVC = AddCarViewController()
        addCarVC.delegateAddCar = self
        self.present(addCarVC, animated: true, completion: nil)
    }
    
    @objc func didSelectButtonClicker(_ sender: UIBarButtonItem) {
        mMode = mMode == .view ? .select : .view
        boxesCarTableView.isEditing = true
        boxesCarTableView.allowsMultipleSelectionDuringEditing = true
    }
    
    @objc func didDeleteButtonClicker(_ sender: UIBarButtonItem) {
        var deleteNeededIndexPath : [IndexPath] = []
        for (key, value) in dictionarySelect {
            if value {
                deleteNeededIndexPath.append(key)
            }
        }
        
        for i in deleteNeededIndexPath.sorted(by: { $0.row > $1.row }) {
            box?.car.remove(at: i.row)
        }
        boxesCarTableView.deleteRows(at: deleteNeededIndexPath, with: .automatic)
        dictionarySelect.removeAll()
        
    }
    
    func setupNavigationsBar() {
        navigationItem.rightBarButtonItems = [selectBarButton,addBarButton]

    }
}

extension BoxesViewController : AddCarDelegate {
    func addCarViewControllerDidSave(car: Car) {
        boxesCarTableView.reloadData()
    }
    
    func addCarViewControllerDidShow() {
        print("Show edit controller")
    }
    
    func addCarViewControllerDidDisapear() {
        print("hide edit controller")
    }
}
