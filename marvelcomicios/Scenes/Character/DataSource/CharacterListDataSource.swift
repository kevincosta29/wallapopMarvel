//
//  CharacterListDataSource.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 12/7/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import Foundation
import KNetwork

protocol CharacterListDataSourceProtocol {
    func getCharacterList(page: Int) async -> (Result<([Character], Int?), KNetworkError>)
}

class CharacterListDataSource: CharacterListDataSourceProtocol {
    
    //-----------------------
    // MARK: VARIABLES
    // MARK: ============
    //-----------------------
    
    private let session: URLSession
    
    //-----------------------
    // MARK: - INIT
    //-----------------------
    
    init(session: URLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)) {
        self.session = session
    }
    
    //-----------------------
    // MARK: - METHODS
    //-----------------------
    
    func getCharacterList(page: Int = 0) async -> (Result<([Character], Int?), KNetworkError>) {
        let endPoint = MarvelComicsEndpoint.wsGetCharacters(params: CharacterListDTO(limit: 20, offset: page * 20))
        let response = await Service.executeRequest(endpoint: endPoint, model: WSCharactersResponse.self, session: session)
        
        switch response {
        case .success(let response):
            if let arrayCharacters = response.data?.results, !arrayCharacters.isEmpty {
                return .success((arrayCharacters, response.data?.total ?? 0))
            } else {
                return .failure(KNetworkError.error(message: Localization.CharacterList.emptyResult))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
