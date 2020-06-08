//
//  Todo.swift
//  HandsOnLab
//
//  Created by Gabriela Bezerra on 07/06/20.
//

import Foundation

struct Todo: Codable {
    let id: String?
    let title: String
    
    init(title: String) {
        self.id = nil
        self.title = title
    }
}
