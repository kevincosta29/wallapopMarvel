//
//  UnwrapFileHelper.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 9/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
import XCTest

struct UnwrapFileHelper {
    static func unwrapFileData(name: String) throws -> Data {
        let url = try XCTUnwrap(Bundle(for: CharacterListDataSourceTest.self).url(forResource: name, withExtension: "json"))
        return try Data(contentsOf: url)
    }
}
