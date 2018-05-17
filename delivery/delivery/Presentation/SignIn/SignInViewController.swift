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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
