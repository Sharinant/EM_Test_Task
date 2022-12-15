//
//  Coordinator.swift
//  TestTask
//
//  Created by Антон Шарин on 08.12.2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator : Coordinator? {get set}
    var children : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    
    func start()
}


class AppCoordinator : Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        navigationController = navCon
    }
    
    func start() {
        print("Started")
        showHomeController()
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func showHomeController() {
    
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
        
    }
    
    func goToDetailPage(for id : Int) {
        let vc = DetailsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
