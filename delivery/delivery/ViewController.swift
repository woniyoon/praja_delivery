//
//  ViewController.swift
//  delivery
//
//  Created by Alireza Davoodi on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import Firebase

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
//        let next = resolver.resolve(ProductListViewController.self)!
//        present(next, animated: true, completion: nil)
        
        let db = Firestore.firestore()
        db.collection("sample_product")
            .getDocuments() { (document, error) in
                if let error = error {
                    print(error)
                    return
                }
                for document in document!.documents {
                    if (document.data() as? Dictionary<String, AnyObject>) != nil {
                        guard let product = SampleProductEntity(dictionary: document.data()) else { return }
                        print("Product name \(product.name)")
                    }
                    
                }
        }
    }
    
    @IBAction func productDetailButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ProductDetailViewController.self)!
        next.productId = "oVhTC6TXjU1a3bG8EabF"
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

