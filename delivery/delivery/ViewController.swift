//
//  ViewController.swift
//  delivery
//
//  Created by Alireza Davoodi on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goHome(_ sender: Any) {
        let next = resolver.resolve(HomeViewController.self)!
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func productListButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ProductListViewController.self)!
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func productDetailButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ProductDetailViewController.self)!
        next.productId = "eS52Nw2aGrAV9PSG5qqb"
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        let next = resolver.resolve(OrderViewController.self)!
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func accountButtonPressed(_ sender: Any) {
        let next = resolver.resolve(AccountViewController.self)!
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        let next = resolver.resolve(UserViewController.self)!
        present(next, animated: true, completion: nil)
    }
}

