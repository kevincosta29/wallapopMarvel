//
//  Configurator.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 1/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation
import UIKit

final class CharacterListConfigurator {
    
    static func prepareView() -> UIViewController {
        let dataSource = CharacterListDataSource()
        let flowManager = CharacterListFlowManager()
        let presenter = CharacterListPresenter(dataSource: dataSource, flowManager: flowManager)
        let viewController = CharacterListViewController(presenter: presenter)
        let navController = UINavigationController(rootViewController: viewController)
        
        flowManager.navigationController = navController
        presenter.view = viewController
        
        return navController
    }
}
