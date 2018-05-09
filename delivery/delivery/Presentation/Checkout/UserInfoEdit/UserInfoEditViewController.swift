//
//  UserInfoEditViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-26.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserInfoEditViewController: UIViewController {

    @IBOutlet var userInfoTextFields: [UITextField]!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    
    var isMember: Bool?
    
    private var viewModel: UserInfoEditViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: UserInfoEditViewModel) -> UserInfoEditViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(UserInfoEditViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        bindView()
        if self.isMember != nil {
            viewModel.fetchUser()
        }
    }
    
    func setTextFields() {
        userInfoTextFields.forEach { (textField) in
            textField.layer.borderColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.4).cgColor
            textField.layer.borderWidth = 1
        }
    }
    
    func bindView() {
        viewModel.firstName.asObservable().bind(to: self.firstNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.lastName.asObservable().bind(to: self.lastNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.email.asObservable().bind(to: self.emailLabel.rx.text).disposed(by: disposeBag)
        viewModel.phoneNumber.asObservable().bind(to: self.phoneNumberLabel.rx.text).disposed(by: disposeBag)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if !(firstNameLabel.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            !(lastNameLabel.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            !(emailLabel.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            !(phoneNumberLabel.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                viewModel.firstName.accept(firstNameLabel.text!)
                viewModel.lastName.accept(lastNameLabel.text!)
                viewModel.email.accept(emailLabel.text!)
                viewModel.phoneNumber.accept(phoneNumberLabel.text!)
            
            viewModel.updateUser().subscribe(onCompleted: {
                let next = resolver.resolve(CheckoutViewController.self)!
//                self.present(next, animated: true, completion: nil)})
                self.navigationController?.popViewController(animated: true)})
            { (err) in
                print(err)
            }
        } else {
            print("all fields are mandatory!")
        }
    }
}
