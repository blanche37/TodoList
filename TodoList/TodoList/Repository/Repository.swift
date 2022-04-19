//
//  Repository.swift
//  TodoList
//
//  Created by yun on 2022/04/19.
//

import Foundation

protocol Repository {
    associatedtype T: Codable
    
    func save(item: T, completion: @escaping () -> ())
    func load(completion: @escaping ([T]) -> ())
}

