//
//  CustomTabBar.swift
//  TestTask
//
//  Created by Антон Шарин on 14.12.2022.
//

import Foundation
import UIKit

@IBDesignable
class CustomTabBarvc : UITabBarController, UITabBarControllerDelegate {
    
    let coordinator = AppCoordinator(navCon: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.start()

      //  self.delegate = self
        self.selectedIndex = 0
        setup()
        setAppearance()
    }
    
    func setup() {
        let vc = coordinator.navigationController
        vc.tabBarItem.title = "• Explorer"
        vc.tabBarItem.image = nil
        
        viewControllers = [vc,
        generate(vc: CartViewController(), title: "", image: UIImage(named: "Cart.png")!),
        generate(vc: UIViewController(), title: "", image: UIImage(named: "Favorite.png")!),
        generate(vc: UIViewController(), title: "", image: UIImage(named: "Profile.png")!)]
        
    }
    
    private func generate(vc: UIViewController, title : String, image : UIImage?) -> UIViewController {
        
    
        vc.tabBarItem.image = image
        vc.tabBarItem.title = title
        
        return vc
    }
    
    override func viewDidLayoutSubviews() {
        self.tabBar.frame = CGRect(x: 0, y: tabBar.frame.minY + 20 , width: tabBar.frame.width , height: tabBar.frame.height)

    }
    
    private func setAppearance() {
        setLayer()
        setIcons()
    }
    
    private func setIcons() {
        tabBar.itemPositioning = .fill
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
        tabBar.items![0].titlePositionAdjustment = UIOffset(horizontal: 18, vertical: -18)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Mark Pro", size: 15)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Mark Pro", size: 15)!], for: .selected)
        
    }
    
    private func setLayer() {
        let x : CGFloat = 10
        let y : CGFloat = 15
        let width = tabBar.bounds.width - x*2
        let height = tabBar.bounds.height + y*2
        

        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: x,
                                                          y: tabBar.bounds.minY - y,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height/2)
        
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        roundLayer.fillColor = colorBlue.cgColor
        tabBar.itemWidth = width/6


    }
    
}
