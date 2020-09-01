//
//  drinkData.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import Foundation




//菜單型別
struct Drink : Codable {
    let brand : String
    let name : String
    let price : String
    let mPrice : String?
    let city : String
    let detail : String
    let recommendIce : String
    let recommendSugar : String
    
    
}



//訂購的飲料跟價錢
struct Order: Codable {
   var orderDrink: String
    var orderPrice : Int
}



//顯示cell頁面的資訊、訂購表單下載上傳更新刪除
struct OrderData:Codable {
    //定義有data參數的型別
    var data : [List]
}
struct List:Codable {
    var date:String
    var name:String
    var drink:String
    var size:String
    var sugar:String
    var ice:String
    var price:Int
    
    init?(json: [String : Any]) {
        guard let date = json["date"] as? String,
            let name = json["name"] as? String,
            let drink = json["drink"] as? String,
            let size = json["size"] as? String,
            let sugar = json["sugar"] as? String,
            let ice = json["ice"] as? String,
            let price = json["price"] as? Int
                
            else {
                return nil
            }
            self.date = date
            self.name = name
            self.drink = drink
            self.size = size
            self.sugar = sugar
            self.ice = ice
            self.price = price
         
    }
    
}


//讀取訂單內容用的
struct TeaChoicesData {
    
    var date: String
    var name: String
    var drink: String
    var size: String
    var sugar: SugarStyle
    var ice: IceStyle
    var price:Int
    
    init() {
            date = ""
            name = ""
            drink = ""
            size = ""
            sugar = .regular
            ice = .regular
            price = 0
          

    }
}





enum SugarStyle:String{
    case regular = "正常", lessSuger = "少糖", halfSuger = "半糖", quarterSuger = "微糖", sugerFree = "無糖"
    
}

enum IceStyle:String{
    case regular = "正常", moreIce = "少冰", easyIce = "微冰", iceFree = "去冰", hot = "熱飲"
}
