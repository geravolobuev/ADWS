//
//  IntermediaryModels.swift
//  Restaraunt
//
//  Created by MAC on 17/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    var prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
