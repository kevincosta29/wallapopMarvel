//
//  CharacterListDTO.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 28/12/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//
import Foundation

struct CharacterListRequest: BaseProtocolRequest {
    var ts: String = ""
    var apikey: String = ""
    var hash: String = ""
    var limit: Int
    var offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        addCommonParams()
    }
}
