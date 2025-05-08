//
//  ComicsResponse.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 8/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation

struct ComicsResponse: Codable {
    
    var code                : Int?
    var status              : String?
    var data                : ComicsDataResponse?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
}

struct ComicsDataResponse: Codable {
    
    var offset              : Int?
    var limit               : Int?
    var total               : Int?
    var count               : Int?
    var results             : [Comic]?
    
    private enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
