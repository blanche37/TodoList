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
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(purchases)
            try data.write(to: url)
            completion()
        } catch {
            print("encodingError")
        }
    }
    
    func load(completion: @escaping ([Purchase]) -> ()) {
        if let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            do {
                self.purchases = try decoder.decode([Purchase].self, from: data)
                completion(purchases)
            } catch {
                print("decodingError")
            }
        }
    }
}

