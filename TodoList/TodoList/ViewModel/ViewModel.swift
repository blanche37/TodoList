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
