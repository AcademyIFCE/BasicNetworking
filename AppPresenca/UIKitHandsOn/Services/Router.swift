//
//  Router.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 14/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

protocol Router {    
    var hostname: String { get }
    var url: URL? { get }
}
