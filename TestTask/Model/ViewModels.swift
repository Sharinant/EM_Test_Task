//
//  ViewModels.swift
//  TestTask
//
//  Created by Антон Шарин on 06.12.2022.
//

import Foundation
import UIKit


struct HotSalesViewModel {
    var phoneImage : UIImage = UIImage(systemName: "house")!
    var phoneImageUrl : String = ""
    var newImage : UIImage = UIImage(systemName: "house")!
    var title : String = "title"
    var subTitle : String = "subtitle"
    var isNew : Bool? = nil
    var isBuy : Bool = true
}


struct BestSellerViewModel {
    var image : String = ""
    var isFav : Bool = false
    var title : String = ""
    var oldPrice : Double = 0
    var newPrice : Double = 0
    
}

struct DetailViewViewModel {
    var images : [String]
    var cpu : String
    var camera : String
    var capacity : [String]
    var color : [String]
    var isFav : Bool
    var price : Double
    var rating : Double
    var sd : String
    var ssd : String
    var title : String
    
}


struct CartViewViewModel {
    var delievery : String
    var total : Double
    var busket : [Busket]
}

struct Busket {
    var image : String
    var price : Double
    var title : String
}
