//
//  TabBar.swift
//  TestTask
//
//  Created by Антон Шарин on 03.12.2022.
//

import Foundation
import UIKit


enum TabItem: String, CaseIterable {
    case home = "home"
    case cart = "cart"
    case favorite = "favorite"
    case profile = "profile"
    
var viewController: UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController()
            
            return vc
        case .cart:
            return CartViewController()
        case .favorite:
            let vc = DetailsViewController()
            return vc
        case .profile:
            return UIViewController()
        }
    }
    // these can be your icons
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .cart:
            return UIImage(named: "Cart.png")!
        case .favorite:
            return UIImage(named: "Favorite.png")!
        case .profile:
            return UIImage(named: "Profile.png")!
        }
    }
var displayTitle: String {
    switch self {
    case .home:
        return "Explorer"
    case .cart:
        return ""
    case .favorite:
        return ""
    case .profile:
        return ""
    }
}
}

