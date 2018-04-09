//
//  AddressEditViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class AddressEditViewController: UIViewController {

    private var viewModel: AddressEditViewModel!
    
    @IBOutlet var textFields: [UITextField]!

    @IBOutlet weak var provinceField: UIView!
    @IBOutlet weak var provinceLabel: UILabel!
    

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet var countryButtons: [UIButton]!
    @IBOutlet var provinceButtons: [UIButton]!
    
    @IBOutlet weak var remarkTextView: UITextView!
    
    static func createInstance(viewModel: AddressEditViewModel) -> AddressEditViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(AddressEditViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
    }

    @IBAction func selectDropdownProvince(_ sender: Any) {
        provinceButtons.forEach { (button) in
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden =
                    !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func selectProvince(_ sender: UIButton) {
        provinceLabel.text = sender.currentTitle
        provinceButtons.forEach { (button) in
            button.isHidden = true
        }
    }
    

    @IBAction func selectDropdownCountry(_ sender: Any) {
        countryButtons.forEach { (button) in
            UIView.animate(withDuration: 0.5, animations: {
                button.isHidden =
                    !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
  
    
    @IBAction func selectCountry(_ sender: UIButton) {
        countryLabel.text = sender.currentTitle
        countryButtons.forEach { (button) in
            button.isHidden = true
        }
    }
    
    func configureTextFields() {
        textFields.forEach { (textField) in
            textField.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            textField.layer.borderWidth = 0.5
        }
        
        self.provinceField.layer.borderColor = UIColor.init(red: 217, green: 217, blue: 217, alpha: 1).cgColor
        self.provinceField.layer.borderWidth = 0.5
    }
}
