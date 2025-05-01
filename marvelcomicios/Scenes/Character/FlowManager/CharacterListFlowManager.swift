//
//  CharacterListFlowManager.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 12/7/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterListFlowManagerProtocol {
    func goToDetail(character: Character)
}

final class CharacterListFlowManager: CharacterListFlowManagerProtocol {
    
    // MARK: VARIABLES
    
    weak var navigationController: UINavigationController?
    
    // MARK: - METHODS
    
    func goToDetail(character: Character) {
        let flowManager = CharacterDetailFlowManager(navController: navigationController, character: character)
        flowManager.start()
    }
    
}
