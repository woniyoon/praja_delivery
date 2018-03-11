//
//  UIExtension.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public class func initialViewControllerFromStoryBoard<T: UIViewController>(_ type: T.Type) -> T? {
        guard var name = NSStringFromClass(T.self).components(separatedBy: ".").last else { return nil }
        if let range = name.range(of: "ViewController") {
            name.replaceSubrange(range, with: "")
        }
        let bundle = Bundle(for: type)
        let object = UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController()
        guard let ret = object as? T else { return nil }
        return ret
    }
}
