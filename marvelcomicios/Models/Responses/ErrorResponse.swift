//
//  APIDecode.swift
//  Marvel Comic
//
//  Created by Kevin Costa on 29/8/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var code                : String?
    var message             : String?
    var description         : String {
        String(format: Localization.Default.errorResponse, code ?? "", message ?? "")
    }
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
