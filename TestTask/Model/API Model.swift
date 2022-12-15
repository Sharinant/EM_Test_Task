//
//  Model.swift
//  TestTask
//
//  Created by Антон Шарин on 05.12.2022.
//

import Foundation



struct HomeStore : Codable {
    var id : Int
    var is_new : Bool?
    var title : String
    var subtitle : String
    var picture : String
    var is_buy : Bool
    
    enum CodingKeys : String,CodingKey {
        case id
        case is_new
        case title = "title"
        case subtitle = "subtitle"
        case picture = "picture"
        case is_buy
    }
}

struct BestSeller : Codable {
    var id : Int
    var is_favorites : Bool
    var title : String
    var price_without_discount : Double
    var discount_price : Double
    var picture : String
   
    
    enum CodingKeys : String,CodingKey {
        case id
        case is_favorites
        case title = "title"
        case price_without_discount
        case discount_price
        case picture = "picture"
    }
    
}

struct DetailPhone : Codable {
    var CPU : String
    var camera : String
    var capacity : [String]
    var color : [String]
    var id : String
    var images : [String]
    var isFavorites : Bool
    var price : Double
    var rating : Double
    var sd : String
    var ssd : String
    var title : String
    
    
    enum CodingKeys : String,CodingKey {
        case CPU = "CPU"
        case camera = "camera"
        case capacity = "capacity"
        case color = "color"
        case id = "id"
        case images = "images"
        case isFavorites
        case price
        case rating
        case sd = "sd"
        case ssd = "ssd"
        case title = "title"
    }
}


struct Cart : Codable {
    
    var basket : [DetailForCart]
    var delivery : String
    var id : String
    var total : Double
    
    enum CodingKeys : String,CodingKey {
        
        case basket
        case delivery = "delivery"
        case id = "id"
        case total
        
    
    }

}

struct DetailForCart : Codable {
    var id : Int
    var images : String
    var price : Double
    var title : String
    
    enum CodingKeys : String,CodingKey {
        case id
        case images = "images"
        case price
        case title = "title"
    }
    
}


struct Home : Codable {
    var home_store : [HomeStore]
    var best_seller : [BestSeller]
}
