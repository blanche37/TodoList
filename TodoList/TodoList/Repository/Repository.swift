//
//  Repository.swift
//  TodoList
//
//  Created by yun on 2022/04/19.
//

import Foundation

protocol Repository {
    func save(purchase: Purchase, completion: @escaping () -> ())
    func load(completion: @escaping ([Purchase]) -> ())
}

final class PurchaseRepository: Repository {
    private var url: URL!
    private var purchases = [Purchase]()
    
    init() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Consumption.plist") {
            self.url = url
            print(url)
        }
    }
    
    func save(purchase: Purchase, completion: @escaping () -> ()) {
        purchases.append(purchase)
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(self.purchases)
                try data.write(to: self.url)
                completion()
            } catch {
                print("encodingError")
            }
        }
    }
    
    func load(completion: @escaping ([Purchase]) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            
            if let data = try? Data(contentsOf: self.url) {
                let decoder = PropertyListDecoder()
                do {
                    self.purchases = try decoder.decode([Purchase].self, from: data)
                    completion(self.purchases)
                } catch {
                    print("decodingError")
                }
            }
        }
    }
}

