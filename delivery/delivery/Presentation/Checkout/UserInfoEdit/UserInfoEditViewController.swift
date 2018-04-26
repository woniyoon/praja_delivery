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
    
    private var viewModel: UserInfoEditViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: UserInfoEditViewModel) -> UserInfoEditViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(UserInfoEditViewController.self)
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
