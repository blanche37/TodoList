//
//  ViewModel.swift
//  TodoList
//
//  Created by yun on 2022/04/23.
//

import Foundation

protocol ViewModel {
    var purchases: [Purchase] { get }
    func save(purchase: Purchase, completion: @escaping () -> ())
    func load(completion: @escaping () -> ())
}

class TodoListViewModel: ViewModel {
    var purchases = [Purchase]()
    var useCase: UseCase!
    
    init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    func save(purchase: Purchase, completion: @escaping () -> ()) {
        purchases.append(purchase)
        useCase.save(purchase: purchase, completion: completion)
        
    }
    
    func load(completion: @escaping () -> ()) {
        useCase.load { [weak self] consumptions in
            self?.purchases = consumptions
            completion()
        }
    }
}
