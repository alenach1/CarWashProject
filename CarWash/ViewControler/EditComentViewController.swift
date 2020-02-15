//
//  EditComentViewController.swift
//  CarWash
//
//  Created by alena on 09.02.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

protocol EditReviewDelegate: class {
    func editViewControllerDidShow() -> Void
    func editViewControllerDidDisapear() -> Void
    func editViewControllerDidSave(review: Review) -> Void
}

class EditComentViewController: UIViewController {
    
    var review: Review?
    let saveButton = UIButton()
    let nameLabel = UILabel()
    let reviewTextView = UITextView()
    
    weak var delegate: EditReviewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayouts()
        configureLable()
        configureButton()
        configureTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.editViewControllerDidShow()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.editViewControllerDidDisapear()
    }

    convenience init(review: Review) {
        self.init()
        self.review = review
    }
    
    fileprivate func setupLayouts() {
        //MARK: - Setup Label
        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: - Setup TextField
        self.view.addSubview(reviewTextView)
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        reviewTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        reviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        reviewTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //MARK: - Setup Button
        self.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 30).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    fileprivate func configureLable() {
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.text = review?.human.allName ?? "Нет данных"
    }
    
    fileprivate func configureTextField() {
        reviewTextView.text = review?.textReview ?? "Нет данных"
        reviewTextView.font = .systemFont(ofSize: 20)
        reviewTextView.delegate = self
    }
    
    fileprivate func configureButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .black
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    @objc func didTapSave() {
        guard let review = review else { return }
        review.textReview = reviewTextView.text
        
        delegate?.editViewControllerDidSave(review: review)
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditComentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        reviewTextView.becomeFirstResponder()
    }
}

