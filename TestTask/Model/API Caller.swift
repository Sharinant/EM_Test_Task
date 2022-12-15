//
//  API Caller.swift
//  TestTask
//
//  Created by Антон Шарин on 05.12.2022.
//

import Foundation

final class APIcaller {
    
    let homeURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    let detailURL = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    let cartURL = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    
    func homePageCall(completion: @escaping (Result<Home,Error>)-> Void)  {
        
        let url = URL(string: homeURL)
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(Home.self, from: data)
                completion(.success(decoded))
                
            }
            catch{
                completion(.failure(error))
            }
            

        }
        task.resume()
        
    }
    
    func detailPageCall(completion: @escaping (Result<DetailPhone,Error>)-> Void)  {
        
        let url = URL(string: detailURL)
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(DetailPhone.self, from: data)
                print(decoded.title)
                completion(.success(decoded))
                
            }
            catch{
                completion(.failure(error))
            }
            

        }
        task.resume()
        
    }
    
    func cartPageCall(completion: @escaping (Result<Cart,Error>)-> Void)  {
        
        let url = URL(string: cartURL)
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(Cart.self, from: data)
                completion(.success(decoded))
                
            }
            catch{
                completion(.failure(error))
            }
            

        }
        task.resume()
        
    }
    
  
    
}
