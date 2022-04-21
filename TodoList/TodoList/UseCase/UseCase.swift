//
//  UseCase.swift
//  TodoList
//
//  Created by yun on 2022/04/21.
//

import Foundation

protocol UseCase {
    func save(purchase: Purchase, completion: @escaping () -> ())
    func load(completion: @escaping ([Purchase]) -> ())
}

class TodoListUseCase: UseCase {
    var repository: Repository = PurchaseRepository()
    
    func save(purchase: Purchase, completion: @escaping () -> ()) {
        repository.save(purchase: purchase, completion: completion)
    }
    
    func load(completion: @escaping ([Purchase]) -> ()) {
        repository.load { consumptions in
            completion(consumptions)
        }
    }
}
