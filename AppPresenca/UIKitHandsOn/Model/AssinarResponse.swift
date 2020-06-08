//
//  AssinarResponse.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 14/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct AssinarResponse: Decodable {
    let error: Bool
    let reason: String
}
