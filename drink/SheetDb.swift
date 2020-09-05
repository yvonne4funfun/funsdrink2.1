//
//  SheetDb.swift
//  drink
//
//  Created by fun on 2020/9/3.
//

import Foundation
struct OrderDetailController {
    static let shared = OrderDetailController()
    var baseUrlString = "https://sheetdb.io/api/v1/4ii05b9pqnc5d)"
    var baseRequest = URLRequest(url: URL(string: "https://sheetdb.io/api/v1/4ii05b9pqnc5d")!)
    //修改上傳的資料
    func updateOrderDetail(order: Download) {
        
        var updateUrlString = "https://sheetdb.io/api/v1/4ii05b9pqnc5d"
               //在api後面加上欄位跟值
                updateUrlString += ("/name/\(order.name)")
               if let urlString = updateUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlString) {
                   var request = URLRequest(url: url)
                //設定HTTP方法為deleted
                   request.httpMethod = "PUT"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let jsonencoder = JSONEncoder()
                if let data = try? jsonencoder.encode(order){
                    let task = URLSession.shared.uploadTask(with: request, from: data) { (returnData, response, error) in
                        let decoder = JSONDecoder()
                        if let returnData = returnData, let dictionary = try? decoder.decode([String: Int].self, from: returnData), dictionary["updated"] == 1{
                                         print("updated successfully")
                                     }else{
                                         print("updated failed")
                                     }
                                 }
                    task.resume()
                }
                
                                    
                                }
                            }
}
