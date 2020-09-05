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



//上傳更新使用
struct OrderData:Codable {
    //定義有data參數的型別
    var data : List
}
struct List:Codable {
    var date:String
    var name:String
    var drink:String
    var size:String
    var price:Int
    var sugar:String
    var ice:String
}


struct ForDownloadData:Codable {
    //下載網路資料時用的，因為上傳到表單後預設都是String，所以不能和上傳使用一樣的型別
    var fordata : [Download]
}

//修改資料
struct UploadToData:Codable {
    var data:[Download]
}


struct Download:Codable {
    var date:String
    var name:String
    var drink:String
    var size:String
    var price:String
    var sugar:String
    var ice:String
    
    
}








struct TeaChoicesData {
    
    var name: String
    var drink: String
    var price: String
    var size: String
    var sugar: SugarLevel
    var ice: IceLevel
    var date: String
    var bubble:String
    
    
    init() {
            name = ""
            drink = ""
            price = ""
            size = ""
            sugar = .regular
            ice = .regular
            date = ""
            bubble = ""

    }
}


enum SugarLevel:String{
    case regular = "正常", lessSuger = "少糖", halfSuger = "半糖", quarterSuger = "微糖", sugerFree = "無糖"
    
}

enum IceLevel:String{
    case regular = "正常", moreIce = "少冰", easyIce = "微冰", iceFree = "去冰",  hot = "熱飲"
}
