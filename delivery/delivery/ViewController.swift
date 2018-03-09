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
        // hello I'm Kento
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        for i in 1...20 {

            let db = Firestore.firestore()
            db.collection("category").whereField("name", isEqualTo: "food")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("category >>>> \(document.documentID) => \(document.data())")
                            let category = Category(name: document.data()["name"] as! String)
                            
                            let subCategory = SubCategory(name: "food",category: category)
                            
                            let product: ProductEntity! = ProductEntity(name: ("pepsi\(i) 250ml "), description: "pepsi description", price: 2.0, brand: "coca cola", discountPercent: 0, subCategory: subCategory, images: ["dhuaisdhau","ashuidashiduhas","image"] )
                            
                            let data = ProductListFirebaseDataStore.init()
                            data.addNewProduct(product: product)
                        }
                    }
            }
        }

        
//        let data = ProductListFirebaseDataStore.init()
//        for product in data.fetchProductList() {
//
//            print("\(product.brand) - \(product.name)")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        let next = storyboard.instantiateInitialViewController() as! ProductDetailViewController
        present(next, animated: true, completion: nil)
        
    }
    
}

