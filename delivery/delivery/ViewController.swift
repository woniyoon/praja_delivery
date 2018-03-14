//
//  ViewController.swift
//  delivery
//
//  Created by Alireza Davoodi on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // hello I'm Kento
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickButton(_ sender: Any) {
        let next = resolver.resolve(ProductDetailViewController.self)!
        present(next, animated: true, completion: nil)
    }
    
    
    @IBAction func goHome(_ sender: Any) {
        print("called!")
        let next = resolver.resolve(HomeViewController.self)!
        present(next, animated: true, completion: nil)
    }
}

