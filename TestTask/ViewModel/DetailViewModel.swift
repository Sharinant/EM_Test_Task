//
//  DetailViewController.swift
//  TestTask
//
//  Created by Антон Шарин on 06.12.2022.
//

import Foundation
import UIKit


protocol DetailViewModelToView : AnyObject {
    func updateUI(with : DetailViewViewModel)
}

class DetailViewModel {
    
    weak var delegate : DetailViewModelToView?
    
    private var imagesArray : [String] = []
    
    private var viewModel : DetailViewViewModel?
    
    private let caller = APIcaller()
    
    func deleteAtIndex(index : Int) {
        
    }
    
    
    func numberOfImages() -> Int {
        return imagesArray.count
    }
    func giveImage(for index : Int) -> String {
        return imagesArray[index]
    }
    
    func getData() {
        caller.detailPageCall { result in
            switch result{
            case .success(let data):
                self.imagesArray = data.images
                self.viewModel = self.transformData(with: data)
                DispatchQueue.main.async {
                    self.delegate?.updateUI(with: self.transformData(with: data))

                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
   private func transformData(with data : DetailPhone) -> DetailViewViewModel {
       return DetailViewViewModel(images: data.images, cpu: data.CPU, camera: data.camera, capacity: data.capacity, color: data.color, isFav: data.isFavorites, price: data.price, rating: data.rating, sd: data.sd, ssd: data.ssd, title: data.title)
    }
    
//    private func getImagesAndTransformData(from data: DetailPhone) -> DetailViewViewModel {
//        data.images.forEach { element in
//            let url = URL(string: element)!
//            let task = URLSession.shared.dataTask(with: url) { data, _, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//                let image = UIImage(data: data)
//                self.imagesArray.append(image!)
//
//            }
//            task.resume()
//        }
//       return transformData(with: data)
//    }
}
