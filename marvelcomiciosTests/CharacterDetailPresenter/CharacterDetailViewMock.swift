//
//  CharacterDetailViewMock.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 9/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
import XCTest
@testable import marvelcomicios

final class CharacterDetailViewMock: CharacterDetailViewInterface {
    var retrievedError = ""
    var toggleLoadingCount = 0
    var loadedSeries = [SectionItem]()
    var loadedComics = [SectionItem]()
    var expectationLoad: XCTestExpectation?
    var expectationErrorMessage: XCTestExpectation?
    
    func loadContent(series: [SectionItem], comics: [SectionItem]) {
        loadedSeries = series
        loadedComics = comics
        expectationLoad?.fulfill()
    }
    
    func toggleLoading() {
        toggleLoadingCount += 1
    }
    
    func showError(errorMessage: String) {
        retrievedError = errorMessage
        expectationErrorMessage?.fulfill()
    }
}
