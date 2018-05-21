

import Foundation
import RxSwift
import RxCocoa
//import RxDataSources

class OrderDetailViewModel : BaseViewModel{
    //Array
    var arrOfOrderDetail = BehaviorRelay<[OrderDetail]>(value: [])
//    var arrOfProduct = BehaviorRelay<[Product]>(value: [])
//    var arrOfUser = BehaviorRelay<[User]>(value: [])
    
    //UserEntity
    var address = BehaviorRelay(value: "")
    var postalCode = BehaviorRelay(value: "")
    var mobileNumber = BehaviorRelay(value: "")
    var cardholder = BehaviorRelay(value: "")
    var cardNumber = BehaviorRelay(value: "")
    var expiryDate = BehaviorRelay(value: "")
    
    //OrderEntity
    var scheduledDeliveryDate = BehaviorRelay(value: "")
    var couponDiscount = BehaviorRelay(value: "")
    var deliveryFee = BehaviorRelay(value: "")
    var totalPrice = BehaviorRelay(value: "")
    var totalBeforeShippingFee = BehaviorRelay(value: "")
    
    var quantityPerItem = BehaviorRelay(value: "")
    var pricePerItem = BehaviorRelay(value: "")
    var productImage = BehaviorRelay<String>(value: "")
    var productName = BehaviorRelay(value: "")
    
    //==============================================================
    
    private var orderUseCase: OrderUseCaseProtocol
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(orderUseCase: OrderUseCaseProtocol) {
        self.orderUseCase = orderUseCase
//        self.userUsecase = userUsecase
    }
    
    //==============================================================
    
    func fetchOrderDetail(with orderId : String){
        orderUseCase.fetchOrderDetail(with: orderId)
            .subscribe(
                onSuccess: {order in
                    if let schedule = order.scheduledDeliveryDate{
                        let scheduleString = DateFormatter.scheduledDeliveryDateInFormat(scheduledDeliveryDate: schedule)
                        print(scheduleString)

                        self.scheduledDeliveryDate.accept(scheduleString)
                    }
                    self.couponDiscount.accept(String(format: "$%0.2f", order.couponDiscount))
                    self.deliveryFee.accept(String(format: "$%0.2f", order.deliveryFee))
                    self.totalPrice.accept(String(format: "$%0.2f", order.totalPrice - order.couponDiscount))
                    self.totalBeforeShippingFee.accept(String(format: "$%0.2f", order.totalPrice - order.couponDiscount - order.deliveryFee))
                    
                    self.arrOfOrderDetail.accept(order.orderDetail)
                    
            }, onError: { error in self.setError(error) }
        ).disposed(by: disposeBag)
    }
    
        
//    func fetchUser(with userId: String) {
//        userUsecase.fetchUser(userId)
//            .subscribe(
//                onSuccess: { (user) in
//                self.arrOfUser.accept([user])
//                self.mobileNumber.accept(user.mobileNumber)
//
//            if let address = user.address {
//                let defaultAddress = address.filter({ $0.isDefault })
//                self.address.accept("\((defaultAddress.first?.address1)!) \((defaultAddress.first?.address2)!)")
////                self.receiver.accept((defaultAddress.first?.receiver)!)
//                self.postalCode.accept((defaultAddress.first?.postalCode)!)
//            }
//
//            if let payment = user.payment {
//                let defaultPayment = payment.filter({ $0.isDefault })
//                self.cardholder.accept((defaultPayment.first?.holderName)!)
//                self.cardNumber.accept((defaultPayment.first?.cardNumber)!)
//                    let expiryDateString = DateFormatter.expiryDateInFormat(expiryDate: (defaultPayment.first?.expiryDate)!)
//                self.expiryDate.accept(expiryDateString)
//            }
//        }, onError: { error in self.setError(error) }
//        ).disposed(by: disposeBag)
//    }

    
}
