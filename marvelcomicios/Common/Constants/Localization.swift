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
        static var title = "character.title".localized()
        static var emptyResult = "character.emptyResult".localized()
    }
    
    enum CharacterDetail {
        static var sectionComics = "character.detail.section.comics".localized()
        static var sectionSeries = "character.detail.section.series".localized()
        static var sectionStories = "character.detail.section.stories".localized()
    }
    
    enum Default {
        static var errorMessage = "defaultErrorMsg".localized()
        static var errorResponse = "error.response.description".localized()
    }
}
