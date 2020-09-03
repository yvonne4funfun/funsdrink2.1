//
//  teaData.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import Foundation

struct drinkData : Codable {
 var Data : [drink]
    
}

struct drink : Codable {
    var name : String
    var price : Int
    var size : String
    var data : String
    var img_url : String
}
