//
//  PresencaAPI.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 17/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

enum PresencaAPI: Router {

    case listar
    case assinar
    
    var hostname: String {
        get {
            return "https://api-presenca.herokuapp.com"
        }
    }
    
    var url: URL? {
        get {
            switch self {
            case .listar: return URL(string: "\(hostname)/presenca/listar")
            case .assinar: return URL(string: "\(hostname)/presenca/assinar")
            }
        }
    }
    
}
