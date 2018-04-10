//
//  UIExtension.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import Cosmos
import RxSwift
import RxCocoa

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

public extension CosmosView {
    public var rx_rating: AnyObserver<Double> {
        return Binder(self) { view, rating in
            view.rating = rating
            }.asObserver()
    }
}

public extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
