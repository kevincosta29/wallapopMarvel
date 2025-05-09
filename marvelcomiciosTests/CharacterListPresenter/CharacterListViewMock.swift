//
//  CharacterListViewMock.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 9/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
import XCTest
@testable import marvelcomicios

final class CharacterListViewMock: CharacterListViewInterface {
    var expectationLoad: XCTestExpectation?
    var expectationErrorMessage: XCTestExpectation?
    var toggleLoadingCount = 0
    var retrievedError = ""
    
    func toggleLoading() {
        toggleLoadingCount += 1
    }
    
    func show(errorMessage: String) {
        retrievedError = errorMessage
        expectationErrorMessage?.fulfill()
    }
    
    func loadContent() {
        expectationLoad?.fulfill()
    }
}
