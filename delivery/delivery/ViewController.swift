//
//  ViewController.swift
//  delivery
//
//  Created by Alireza Davoodi on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()

        let home = resolver.resolve(HomeViewController.self)!
        let order = resolver.resolve(OrderViewController.self)!
        let account = resolver.resolve(AccountViewController.self)!
        
        home.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "tab1"), tag: 0)
        order.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "tab2"), tag: 0)
        account.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "tab3"), tag: 0)
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .red
        self.addChildViewController(home)
        self.addChildViewController(order)
        self.addChildViewController(account)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func goHome(_ sender: Any) {
//        let next = resolver.resolve(HomeViewController.self)!
//        present(next, animated: true, completion: nil)
//    }
//
//    @IBAction func productListButtonPressed(_ sender: Any) {
//        let next = resolver.resolve(ProductListViewController.self)!
//        present(next, animated: true, completion: nil)
//    }
//
//    @IBAction func productDetailButtonPressed(_ sender: Any) {
//        let next = resolver.resolve(ProductDetailViewController.self)!
//        next.productId = "oVhTC6TXjU1a3bG8EabF"
//        present(next, animated: true, completion: nil)
//    }
//
//    @IBAction func orderButtonPressed(_ sender: Any) {
//        let next = resolver.resolve(OrderViewController.self)!
//        present(next, animated: true, completion: nil)
//    }
//
//    @IBAction func accountButtonPressed(_ sender: Any) {
//        let next = resolver.resolve(AccountViewController.self)!
//        next.userEmail = "diegoh.vanni@gmail.com"
//        present(next, animated: true, completion: nil)
//    }
}

