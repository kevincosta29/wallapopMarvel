//
//  CharacterDetailViewModel.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 28/12/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

import Foundation
import KNetwork

protocol CharacterDetailPresenterInterface {
    var arrayComics: [Comic] { get }
    var arraySeries: [Serie] { get }
    
    func viewReady()
    func retryLoad()
}

final class CharacterDetailPresenter: CharacterDetailPresenterInterface {
    
    //-----------------------
    // MARK: VARIABLES
    // MARK: ============
    //-----------------------
    
    var arrayComics: [Comic] = []
    var arraySeries: [Serie] = []
    weak var view: CharacterDetailViewInterface?
    private let dataSource: CharacterDetailDataSourceProtocol
    private let flowManager: CharacterDetailFlowManagerProtocol
    private let character: Character
    
    //-----------------------
    // MARK: - LIVE APP
    //-----------------------
    
    init(dataSource: CharacterDetailDataSourceProtocol,
         flowManager: CharacterDetailFlowManagerProtocol,
         character: Character) {
        self.dataSource = dataSource
        self.flowManager = flowManager
        self.character = character
    }
    
    //-----------------------
    // MARK: - METHODS
    //-----------------------
    
    func viewReady() {
        guard let id = character.id else {
            view?.showError(errorMessage: Localization.Default.errorMessage)
            return
        }
        
        Task { @MainActor in
            view?.toggleLoading()
            await retrieveComics(id: id)
            await retrieveSeries(id: id)
            view?.toggleLoading()
            view?.loadContent()
        }
    }
    
    func retryLoad() {
        viewReady()
    }
}

private extension CharacterDetailPresenter {
    func retrieveComics(id: Int) async {
        arrayComics = []
        let responseComics = await dataSource.getComics(id: character.id ?? 0)
        if case .success(let array) = responseComics {
            arrayComics = array
        }
    }
    
    func retrieveSeries(id: Int) async {
        arraySeries = []
        let responseSeries = await dataSource.getSeries(id: character.id ?? 0)
        if case .success(let array) = responseSeries {
            arraySeries = array
        }
    }
}
