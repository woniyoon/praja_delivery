//
//  SignInViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-05-16.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    // MARK: - UIViews
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Instance
    
    private var viewModel: SignInViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - ViewController
    
    static func createInstance(viewModel: SignInViewModel) -> SignInViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(SignInViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: Any) {
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
    
    @IBAction func keepGuestMode(_ sender: Any) {
    }
    
}
