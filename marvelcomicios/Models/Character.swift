//
//  Character.swift
//  Marvel Comic
//
//  Created by Kevin Costa on 30/8/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

struct Character: Codable {
    var id              : Int?
    var name            : String?
    var description     : String?
    var modified        : String?
    var thumbnail       : Thumbnail?
}
