//
//  HomeViewModel.swift
//  TestTask
//
//  Created by Антон Шарин on 05.12.2022.
//

import Foundation
import UIKit

protocol HomeViewModelToView : AnyObject {
    func updateUI()
}

class HomeViewModel {
    
    
    let categoryImages : [UIImage] = [UIImage(named: "Phone")!,UIImage(named: "PC")!,UIImage(named: "Health")!,UIImage(named: "Books")!,UIImage(named: "Phone")!]
    let categoryNames : [String] = ["Phones","Computer","Health","Books","Tools"]
    
    var hotSalesViewModels = [HotSalesViewModel()]
    var bestSellersViewModels = [BestSellerViewModel()]
    
    weak var delegate : HomeViewModelToView?
    
    var hotSalesImages : [UIImage] = []
    
    
    func getCategory(for index : Int) -> (UIImage,String) {
        let category = (categoryImages[index],categoryNames[index])
        return category
    }
    
    func getHotSalesViewModel(for index : Int) -> HotSalesViewModel {
        return hotSalesViewModels[index]
    }
    
    func getBestSellerViewModel(for index : Int) -> BestSellerViewModel {
        return bestSellersViewModels[index]
    }
    
    func getNumberOfItemsBestSeller() -> Int {
        return bestSellersViewModels.count
    }
    
    func getNumberOfItemsHotSales() -> Int {
        return hotSalesViewModels.count
    }
    
    let caller = APIcaller()
    
    func testData() {
        caller.homePageCall(completion: { result in
            switch result {
            case .success(let data):
                self.hotSalesViewModels = self.transformDataToHotSalesViewModel(with: data)
                self.bestSellersViewModels = self.transformDataToBestSellerViewModel(with: data)
                self.delegate?.updateUI()
               
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    func transformDataToHotSalesViewModel(with data : Home) -> [HotSalesViewModel] {
        
        var array : [HotSalesViewModel] = []
        array.append(contentsOf: data.home_store.compactMap({ return HotSalesViewModel(
            phoneImage: UIImage(systemName: "star")!,
            phoneImageUrl: $0.picture,
            newImage: UIImage(systemName: "house")!,
            title: $0.title,
            subTitle: $0.subtitle,
            isNew: $0.is_new,
            isBuy: $0.is_buy)
            
        }))
        return array
    }
    
    func transformDataToBestSellerViewModel(with data : Home) -> [BestSellerViewModel] {
        var array : [BestSellerViewModel] = []
        array.append(contentsOf: data.best_seller.compactMap({ return BestSellerViewModel(
            image: $0.picture,
            isFav: $0.is_favorites,
            title: $0.title,
            oldPrice: $0.discount_price,
            newPrice: $0.price_without_discount)
            
        }))
        return array
    }
    
    
   
}
