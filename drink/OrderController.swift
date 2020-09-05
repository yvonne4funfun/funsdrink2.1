//
//  orderController.swift
//  drink
//
//  Created by fun on 2020/9/3.
//

import UIKit

class OrderController: UIViewController {

    struct OrderController {
        static let shared  = OrderController()
        func getOrders(from fordata: [Download], completion: ([ForDownloadData]?) -> Void) {
            var orders = [Download]()
            for i in 0...fordata.count - 1 {
                let fordata = fordata[i]
                if orders.count == 0 {
                    let order = ForDownloadData(fordata: [fordata])
                    orders.append(order)
                }else {
                    for i in 0...orders.count - 1 {
                        let innerOrderDetail = orders[i].fordata[0]
                        if isTheSameOrder(lhs: orderDetail, rhs: innerOrderDetail) {
                            orders[i].fordata.append(orderDetail)
                            break
                        }else if i == orders.count - 1 {
                            let order = Order(fordata: [orderDetail])
                            orders.append(order)
                        }
                    }
                }
                
            }
            completion(orders)
        }

}
