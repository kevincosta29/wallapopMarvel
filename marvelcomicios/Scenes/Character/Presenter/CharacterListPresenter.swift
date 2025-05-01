//
//  File.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 1/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation

protocol CharacterListPresenterInterface {
    
    var arrayCharacters: [Character] { get }
    
    func retrieveCharacterList()
    func viewReady()
    func retryLoad()
    func goToDetail(id: Int)
}

final class CharacterListPresenter: CharacterListPresenterInterface {
    
    private var dataSource: CharacterListDataSourceProtocol
    private var flowManager: CharacterListFlowManagerProtocol
    weak var view: CharacterListViewInterface?
    var arrayCharacters: [Character] = []
    
    init(dataSource: CharacterListDataSourceProtocol,
         flowManager: CharacterListFlowManagerProtocol) {
        self.dataSource = dataSource
        self.flowManager = flowManager
    }
    
    func retrieveCharacterList() {
        view?.toggleLoading()
        Task { @MainActor in
            let response = await dataSource.getCharacterList()
            view?.toggleLoading()
            
            switch response {
            case .success(let array):
                arrayCharacters = array
                view?.loadContent()
            case .failure(let error):
                view?.show(errorMessage: error.description)
            }
        }
    }
    
    func viewReady() {
        retrieveCharacterList()
    }
    
    func retryLoad() {
        retrieveCharacterList()
    }
    
    func goToDetail(id: Int) {
        flowManager.goToDetail(character: arrayCharacters[id])
    }
}
