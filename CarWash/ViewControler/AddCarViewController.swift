//
//  AddCarViewController.swift
//  CarWash
//
//  Created by alena on 12.02.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

protocol AddCarDelegate: class {
    func addCarViewControllerDidShow() -> Void
    func addCarViewControllerDidDisapear() -> Void
    func addCarViewControllerDidSave(car: Car) -> Void
}

class AddCarViewController: UIViewController {
    
    var box : Box?
    let textFieldAddCar = UITextField()
    let buttonGoAddCar = UIButton()
    let labelAddCar = UILabel()
    
    weak var delegateAddCar: AddCarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayouts()
        configureLable()
        configureTextField()
        configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegateAddCar?.addCarViewControllerDidShow()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegateAddCar?.addCarViewControllerDidDisapear()
    }
    
    
    fileprivate func setupLayouts() {
        //MARK: - Setup Label Add Car
        self.view.addSubview(labelAddCar)
        labelAddCar.translatesAutoresizingMaskIntoConstraints = false
        labelAddCar.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        labelAddCar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        labelAddCar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        labelAddCar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: - Setup TextField Add Car
        self.view.addSubview(textFieldAddCar)
        textFieldAddCar.translatesAutoresizingMaskIntoConstraints = false
        textFieldAddCar.topAnchor.constraint(equalTo: labelAddCar.bottomAnchor, constant: 20).isActive = true
        textFieldAddCar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFieldAddCar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textFieldAddCar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: - Setup Button Add Car
        self.view.addSubview(buttonGoAddCar)
        buttonGoAddCar.translatesAutoresizingMaskIntoConstraints = false
        buttonGoAddCar.topAnchor.constraint(equalTo: textFieldAddCar.bottomAnchor, constant: 20).isActive = true
        buttonGoAddCar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonGoAddCar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonGoAddCar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    fileprivate func configureLable() {
        labelAddCar.text = "Введите название автомобиля"
        labelAddCar.font = .systemFont(ofSize: 15)
        labelAddCar.backgroundColor = .systemBackground
        labelAddCar.textAlignment = .center
    }
    
    fileprivate func configureTextField() {
        textFieldAddCar.font = .systemFont(ofSize: 15)
        textFieldAddCar.placeholder = "Лада Ларгус 228"
        textFieldAddCar.textAlignment = .center
        
    }
    
    fileprivate func configureButton() {
        buttonGoAddCar.setTitle("Добавить", for: .normal)
        buttonGoAddCar.backgroundColor = .black
        buttonGoAddCar.addTarget(self, action: #selector(didAddCar), for: .touchUpInside)
        }
        
        @objc func didAddCar() {
            if textFieldAddCar.text != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy HH:mm"
            let newCar = Car(carName: (textFieldAddCar.text) ?? "Ошибка ввода", timeWash: formatter.string(from: Date.init()))
            box?.car.append(newCar)
            delegateAddCar?.addCarViewControllerDidSave(car: newCar)
        }
            self.dismiss(animated: true, completion: nil)
    }
}

extension AddCarViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldAddCar.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldAddCar.resignFirstResponder()
    }
}
