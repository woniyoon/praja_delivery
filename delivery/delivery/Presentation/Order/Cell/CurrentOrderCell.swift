//
//  CurrentOrderCell.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/04/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import UIKit
import Kingfisher

class CurrentOrderCell: UITableViewCell {
    
    static var Identifier = "CurrentOrderCell"

    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var scheduledDeliveryDate: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var line: BorderLabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var purchasedDate: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var currentBox: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Shadow Effect
        currentBox.layer.shadowOffset = CGSize(width: 0, height: 1)
        currentBox.layer.shadowColor = UIColor.black.cgColor
        currentBox.layer.shadowRadius = 2.0
        currentBox.layer.shadowOpacity = 0.40
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
    var order : Order?{
        didSet{
            guard order != nil else {return}
            
            //dark background color
            self.scheduledDeliveryDate.text = DateFormatter.scheduledDeliveryDateInFormat(scheduledDeliveryDate: (order?.scheduledDeliveryDate)!)
            
            self.status.text = order?.status
            
            // images
            if status.text == "Received Order" {
                self.statusImage?.image = UIImage(named: "orders_1")
            } else if status.text == "Packed for delivery" {
                self.statusImage?.image = UIImage(named: "orders_2")
            } else if status.text == "On delivery" {
                self.statusImage?.image = UIImage(named: "orders_3")
            } else if status.text == "Order arriving soon!" {
                self.statusImage?.image = UIImage(named: "orders_4")
            } else{
            }
            
            let imageUrlString = order?.orderDetail[0].productImage
            let imageUrl: URL = URL(string: imageUrlString!)!
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: imageUrlString)
            self.productImage.kf.setImage(with: resource)
            
            self.productName.text = order?.orderDetail[0].productName
            self.quantity.text = String(order!.orderDetail.count)
            self.purchasedDate.text = DateFormatter.purchasedDateInFormat(purchasedDate: ((order?.deliveryInfo["purchasedDate"])!)!)
            
            self.totalPrice.text = String(format:"%.2f", (order?.totalPrice)! - (order?.couponDiscount)!)
            
        }
    }
    
    
    // productName & productImage
    var product: Product? {
        didSet {
            guard let product = product else { return }
            self.productName.text = product.name
            
            let imageUrlString = product.images[0]
            let imageUrl:URL = URL(string: imageUrlString)!
            
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: product.name)
            self.productImage.kf.setImage(with: resource)
        }
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
