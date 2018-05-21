//
//  OrderDetailVC.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/26.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class OrderDetailViewController: BaseViewController {
    
    // MARK : IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var whiteview: UIView!
    @IBOutlet weak var scheduledDeliveryDate: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var payment: UILabel!
    
    @IBOutlet weak var coupon: UILabel!
    @IBOutlet weak var totalBeforeShippingFee: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    

    
    //-------------------------------------
    // MARK : Public Properties
    
    private let disposeBag : DisposeBag = DisposeBag()
    
    private var viewModel: OrderDetailViewModel!
    public var orderId: String!
    
    //-------------------------------------
    // MARK : UIViewController
    
    static func createInstance(viewModel: OrderDetailViewModel) -> OrderDetailViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(OrderDetailViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Your Order Detail"
        configureTableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .none
        bindView()
        viewModel.fetchOrderDetail(with: orderId)
        
        //ジグザグ呼び出し
        applyZigZagEffect(givenView: whiteview)
        //shadow 効かない
        //        whiteview.layer.shadowOffset = CGSize(width: 0, height: 1)
        //        whiteview.layer.shadowColor = UIColor.black.cgColor
        //        whiteview.layer.shadowRadius = 2.0
        //        whiteview.layer.shadowOpacity = 0.40
        //        whiteview.layer.masksToBounds = false
        //        self.view.addSubview(whiteview)
        
        self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    }
    
    private func registerCell(){
        tableView.register(UINib(nibName: OrderDetailCell.Identifier, bundle: nil), forCellReuseIdentifier: OrderDetailCell.Identifier)
    }
    
    private func configureTableView() {
        registerCell()
        //        tableView.estimatedRowHeight = 300
        tableView.allowsSelection = true
    }

    
    //-------------------------------------
    // MARK : DataSource
    func bindView(){
        viewModel.scheduledDeliveryDate.asObservable()
            .bind(to: scheduledDeliveryDate.rx.text)
            .disposed(by: disposeBag)
        viewModel.couponDiscount.asObservable()
            .bind(to: coupon.rx.text)
            .disposed(by: disposeBag)
        viewModel.totalBeforeShippingFee.asObservable()
            .bind(to: totalBeforeShippingFee.rx.text)
            .disposed(by:disposeBag)
        viewModel.deliveryFee.asObservable()
            .bind(to: deliveryFee.rx.text)
            .disposed(by:disposeBag)
        viewModel.totalPrice.asObservable()
            .bind(to: totalPrice.rx.text)
            .disposed(by:disposeBag)
        viewModel.arrOfOrderDetail.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: OrderDetailCell.Identifier, cellType: OrderDetailCell.self)) {
                row, item, cell in
                cell.orderDetail = item
        }.disposed(by: disposeBag)
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
    
    func applyZigZagEffect(givenView: UIView) {
        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        shapeLayer.path = self.pathZigZagForView(givenView: givenView).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.masksToBounds = true
        shapeLayer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        shapeLayer.shadowOffset = CGSize(width: 0, height: 1)
        givenView.layer.mask = shapeLayer
    }
}


@IBDesignable
class Shadow: UIView {
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if layer.shadowColor != nil {
                return UIColor.clear
            }
            else {
                return nil
            }
        }
    }
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
}
