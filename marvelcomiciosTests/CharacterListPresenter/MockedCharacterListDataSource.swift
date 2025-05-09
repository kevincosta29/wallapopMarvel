//
//  MockedCharacterListDataSource.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 13/8/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import Foundation
import KNetwork
@testable import marvelcomicios

class MockedCharacterListDataSource: CharacterListDataSourceProtocol {
    var result: (Result<([Character], Int?), KNetworkError>)?
    
    func getCharacterList(page: Int) async -> Result<([Character], Int?), KNetworkError> {
        guard result != nil else {
            return .failure(.error(message: "FAIL"))
        }
        return result!
    }
    
}
