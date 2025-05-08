//
//  CharacterDetailConfigurator.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 5/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
import UIKit

final class CharacterDetailConfigurator {
    
    static func prepareView(for character: Character) -> UIViewController {
        let dataSource = CharacterDetailDataSource()
        let presenter = CharacterDetailPresenter(dataSource: dataSource,
                                                 character: character)
        let viewController = CharacterDetailViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
    
}
