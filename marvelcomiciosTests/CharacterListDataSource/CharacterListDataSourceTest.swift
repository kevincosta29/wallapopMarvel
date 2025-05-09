//
//  CharacterListDataSourceTest.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 13/8/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import XCTest
import KNetwork
@testable import marvelcomicios

class CharacterListDataSourceTest: XCTestCase {
    
    private var dataCharacterResponse: Data!
    private var arrayCharacter: [Character]!
    // private var session: MockURLSession!
    
    override func setUpWithError() throws {
        // session = MockURLSession()
        
        dataCharacterResponse = try UnwrapFileHelper.unwrapFileData(name: "characterListMock")
        arrayCharacter = try KParser.parserData(dataCharacterResponse)
    }
    
    func test_getListSuccess() async throws {
        // Given
        let objResponse = CharactersResponse(code: nil,
                                             status: nil,
                                             data: CharactersDataResponse(offset: 0, limit: 0, total: 0, count: 0, results: arrayCharacter))
        let data = try KParser.parserObject(objResponse)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 200), data)
        }
        
        // When
        let dataSource = CharacterListDataSource(session: MockNetworking.urlSession)
        let response = await dataSource.getCharacterList()
        
        // Then
        switch response {
        case .success(let response):
            XCTAssert(!response.0.isEmpty)
            XCTAssertEqual(arrayCharacter.count, response.0.count)
        case .failure(_):
            XCTFail()
        }
    }
    
    func test_getListEmpty() async throws {
        // Given
        let objResponse = CharactersResponse(code: nil, status: nil, data: CharactersDataResponse(offset: 0, limit: 0, total: 0, count: 0, results: []))
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            return (self.prepareResponse(status: 200), try KParser.parserObject(objResponse))
        }
        
        // When
        let dataSource = CharacterListDataSource(session: MockNetworking.urlSession)
        let response = await dataSource.getCharacterList()
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssert(!error.description.isEmpty)
        }
    }
    
    func test_getListFailure() async throws {
        // Given
        MockURLProtocol.error = KNetworkError.error(message: "")
        
        // When
        let dataSource = CharacterListDataSource(session: MockNetworking.urlSession)
        let response = await dataSource.getCharacterList()
        
        // Then
        switch response {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssert(!error.description.isEmpty)
        }
    }
    
    private func prepareResponse(status: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "https://gateway.marvel.com:443/v1/public/characters")!,
                        statusCode: status,
                        httpVersion: nil,
                        headerFields: ["Content-Type": "application/json"])!
    }

}
