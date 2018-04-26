//
//  QuantityPopUpController.swift
//  delivery
//
//  Created by Bacelar on 2018-04-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class QuantityPopUpController: UIViewController {

    @IBOutlet weak var quantityView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var textQuantity: UILabel!
    
    var productQuantity: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textQuantity.text = String(productQuantity)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        if productQuantity>0 {
            productQuantity -= 1
        } else {
            productQuantity = 0
        }
        
        textQuantity.text = String(productQuantity)
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
        productQuantity += 1
        
        textQuantity.text = String(productQuantity)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != quantityView {
            dismiss(animated: true, completion: nil)
        }
    }

}
