//
//  CharacterListFlowManagerMock.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 9/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
@testable import marvelcomicios

final class CharacterListFlowManagerMock: CharacterListFlowManagerProtocol {
    var retrievedCharacter: Character?
    func goToDetail(character: Character) {
        retrievedCharacter = character
    }
}
