//
//  OrderReviewViewController.swift
//  delivery
//
//  Created by Bacelar on 2018-05-21.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Firebase
import Stripe

class OrderReviewViewController: BaseViewController {
    
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var orderReviewView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var layerBox: UIView!
    
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var totalBeforeShippingFee: UILabel!
    @IBOutlet weak var shippingFee: UILabel!
    @IBOutlet weak var totalPurchase: UILabel!
    public var viewModel: OrderReviewViewModel!
    
    static func createInstance(viewModel: OrderReviewViewModel) -> OrderReviewViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(OrderReviewViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        bindOrderReview()
        applyZigZagEffect(givenView: layerBox)
        viewModel.fetchShoppingCartList()
        viewModel.fetchUser()
        self.view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
    }
    
    private func bindOrderReview() {

        viewModel.address.asObservable()
            .bind(to: address.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.postalCode.asObservable()
            .bind(to: postalCode.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.mobileNumber.asObservable()
            .bind(to: phoneNumber.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalBeforeShippingFee.asObservable()
            .bind(to: totalBeforeShippingFee.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.shippingFee.asObservable()
            .bind(to: shippingFee.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.total.asObservable()
            .bind(to: totalPurchase.rx.text)
            .disposed(by: disposeBag)


    }
    
    
    @IBAction func close(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
   
    @IBAction func continueShopping(_ sender: Any) {
        let next = resolver.resolve(ProductListViewController.self)!
        next.keyword = ""
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    @IBAction func didTapPayNow(_ sender: Any) {
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true)
        //        navigationController?.pushViewController(addCardViewController, animated: true)
    }
    
    func pathZigZagForView(givenView: UIView) ->UIBezierPath
    {
                
        let width = givenView.frame.size.width
        let height = givenView.frame.size.height
        
        let zigZagWidth = CGFloat(7)
        let zigZagHeight = CGFloat(5)
        let yInitial = height-zigZagHeight
        
        let zigZagPath = UIBezierPath()
        zigZagPath.move(to: CGPoint(x:0, y:0))
        zigZagPath.addLine(to: CGPoint(x:0, y:yInitial))
        
        var slope = -1
        var x = CGFloat(0)
        var i = 0
        while x < width {
            x = zigZagWidth * CGFloat(i)
            let p = zigZagHeight * CGFloat(slope) - 5
            let y = yInitial + p
            let point = CGPoint(x: x, y: y)
            zigZagPath.addLine(to: point)
            slope = slope*(-1)
            i += 1
        }
        zigZagPath.addLine(to: CGPoint(x:width,y: 0))
        zigZagPath.addLine(to: CGPoint(x:0,y: 0))
        zigZagPath.close()
        return zigZagPath
    }
    
    func createShadowLayer() -> CALayer {
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
        shadowLayer.shadowRadius = 2.0
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        return shadowLayer
    }
    
    func applyZigZagEffect(givenView: UIView) {
        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        shapeLayer.path = self.pathZigZagForView(givenView: givenView).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.masksToBounds = true
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0.1
        givenView.layer.addSublayer(shapeLayer)
        
        let shadowSubLayer = createShadowLayer()
        shadowSubLayer.insertSublayer(shapeLayer, at: 0)
        givenView.layer.addSublayer(shadowSubLayer)
    }
    
}
@IBDesignable
class LineView: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 1.0
    @IBInspectable var lineColor: UIColor? {
        didSet {
            lineCGColor = lineColor?.cgColor
        }
    }
    var lineCGColor: CGColor?
    
    override func draw(_ rect: CGRect) {
        // Draw a line from the left to the right at the midpoint of the view's rect height.
        let midpoint = self.bounds.size.height / 2.0
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(lineWidth)
            if let lineCGColor = self.lineCGColor {
                context.setStrokeColor(lineCGColor)
            }
            else {
                context.setStrokeColor(UIColor.black.cgColor)
            }
            context.move(to: CGPoint(x: 0.0, y: midpoint))
            context.addLine(to: CGPoint(x: self.bounds.size.width, y: midpoint))
            context.strokePath()
        }
    }
}

extension OrderReviewViewController: STPAddCardViewControllerDelegate {
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        //2000 = 20.00 (pass amount as integer for stripe)
        
        var amountString = self.totalPurchase.text?.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        amountString = amountString?.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        amountString = amountString?.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        amountString = amountString?.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        
        let amount = Int(amountString!)
        
        StripeClient.shared.completeCharge(with: token, amount: amount!) { result in
            switch result {
            // 1
            case .success:
                completion(nil)
                
                let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(alertAction)
//                self.present(alertController, animated: true)
//                self.navigationController?.popViewController(animated: true)
                //
                let next = resolver.resolve(HomeViewController.self)!
                self.present(next, animated: true)
                self.viewModel.saveOrder()
//                self.navigationController?.pushViewController(next, animated: true)
            // 2
            case .failure(let error):
                completion(error)
            }
        }
    }
}
