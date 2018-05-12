//
//  AccountEditViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-05-10.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AccountEditViewController: UIViewController {

    private var viewModel: AccountEditViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var birthDateLabel: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    let picker = UIDatePicker()
    
    static func createInstance(viewModel: AccountEditViewModel) -> AccountEditViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(AccountEditViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        viewModel.fetchUser()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        createDatePicker()
    }

    func bindView() {
        viewModel.firstName.asObservable()
            .bind(to: firstNameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.lastName.asObservable()
            .bind(to: lastNameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.phoneNumber.asObservable()
            .bind(to: phoneNumberLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.email.asObservable()
            .bind(to: emailLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.birthDate.asObservable()
            .bind(to: birthDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(updateBirthDate))
        toolBar.setItems([done], animated: false)
        
        picker.datePickerMode = .date
        
        birthDateLabel.inputAccessoryView = toolBar
        birthDateLabel.inputView = picker
    }
    
    
    func updateBirthDate() {
        birthDateLabel.text = DateFormatter.birthDateInFormat(birthDate: picker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func updatePassword(_ sender: Any) {
        
    }
    
    func doneButtonTapped() {
        print("done tapped!")
        
    }
}
