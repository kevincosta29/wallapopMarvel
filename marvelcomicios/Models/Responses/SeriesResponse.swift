//
//  SeriesResponse.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 8/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation

struct SeriesResponse: Codable {
    
    var code                : Int?
    var status              : String?
    var data                : SeriesDataResponse?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
}

struct SeriesDataResponse: Codable {
    
    var offset              : Int?
    var limit               : Int?
    var total               : Int?
    var count               : Int?
    var results             : [Serie]?
    
    private enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
