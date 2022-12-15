//
//  CartViewModel.swift
//  TestTask
//
//  Created by Антон Шарин on 08.12.2022.
//

import Foundation


protocol cartViewModelToView : AnyObject {
    func updateUI(with data : CartViewViewModel)
}

class CartViewModel{
    
    weak var delegate : cartViewModelToView?
    
    var viewModel : CartViewViewModel?
    
    let caller = APIcaller()
    
    func deleteAtIndex(index:Int) {
        viewModel?.busket.remove(at: index)
    }
    
    func busketDataToCell(for index : Int) -> Busket {
        return viewModel?.busket[index] ?? Busket(image: "", price: 0, title: "")
    }
    
    func numberOfItems() -> Int {
        return viewModel?.busket.count ?? 0
    }
    
    func getData() {
        caller.cartPageCall { result in
            switch result{
            case .success(let data):
                self.viewModel = self.transformData(data: data)
                self.delegate?.updateUI(with: self.viewModel!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func transformData(data : Cart) -> CartViewViewModel {
        return CartViewViewModel(delievery: data.delivery, total: data.total, busket: data.basket.map({ return Busket(image: $0.images, price: $0.price, title: $0.title)
            
        }))
    }
    
    
    
}
