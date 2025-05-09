//
//  Localization.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 3/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation

enum Localization {
    enum CharacterList {
        static var title: String { "character.title".localized() }
        static var emptyResult: String { "character.emptyResult".localized() }
        static var searchBarPalceHolder: String { "character.search.placeholder".localized() }
    }
    
    enum CharacterDetail {
        static var sectionComics: String { "character.detail.section.comics".localized() }
        static var sectionSeries: String { "character.detail.section.series".localized() }
        static var sectionStories: String { "character.detail.section.stories".localized() }
    }
    
    enum Default {
        static var errorMessage: String { "defaultErrorMsg".localized() }
        static var errorResponse: String { "error.response.description".localized() }
    }
}
