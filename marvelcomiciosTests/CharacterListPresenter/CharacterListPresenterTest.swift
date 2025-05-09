//
//  CharacterListPresenterTest.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 4/1/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import XCTest
import KNetwork
@testable import marvelcomicios

class CharacterListPresenterTest: XCTestCase {
    
    private var dataSource: MockedCharacterListDataSource!

    override func setUpWithError() throws {
        dataSource = MockedCharacterListDataSource()
    }
    
    func test_CharacterList_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_CharacterList_Success")
        let mockDataResponse = try UnwrapFileHelper.unwrapFileData(name: "characterListMock")
        let arrayObjects: [Character] = try KParser.parserData(mockDataResponse)
        dataSource.result = .success((arrayObjects, 100))
        let presenter = CharacterListPresenter(dataSource: dataSource, flowManager: CharacterListFlowManagerMock())
        let mockView = CharacterListViewMock()
        mockView.expectationLoad = expectation
        presenter.view = mockView
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presenter.arrayCharacters.count, arrayObjects.count)
    }
    
    func test_CharacterListEmpty_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_CharacterListEmpty_Success")
        dataSource.result = .failure(KNetworkError.error(message: "test_CharacterListEmpty_Success"))
        let presenter = CharacterListPresenter(dataSource: dataSource, flowManager: CharacterListFlowManagerMock())
        let mockView = CharacterListViewMock()
        mockView.expectationErrorMessage = expectation
        presenter.view = mockView
        
        // When
        presenter.viewReady()

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(presenter.arrayCharacters.isEmpty)
        XCTAssertEqual(mockView.retrievedError, "test_CharacterListEmpty_Success")
    }
    
    func test_CharacterListNilData_Success() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_CharacterListNilData_Success")
        dataSource.result = .failure(KNetworkError.error(message: "test_CharacterListNilData_Success"))
        let presenter = CharacterListPresenter(dataSource: dataSource, flowManager: CharacterListFlowManagerMock())
        let mockView = CharacterListViewMock()
        mockView.expectationErrorMessage = expectation
        presenter.view = mockView

        // When
        presenter.viewReady()

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presenter.arrayCharacters.count, 0)
        XCTAssertEqual(mockView.retrievedError, "test_CharacterListNilData_Success")
    }
    
    func test_CharacterList_Failure() throws {
        // Given
        let expectation = XCTestExpectation(description: "test_CharacterList_Failure")
        dataSource.result = .failure(KNetworkError.error(message: "test_CharacterList_Failure"))
        let presenter = CharacterListPresenter(dataSource: dataSource, flowManager: CharacterListFlowManagerMock())
        let mockView = CharacterListViewMock()
        mockView.expectationErrorMessage = expectation
        presenter.view = mockView
        
        // When
        presenter.viewReady()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presenter.arrayCharacters.count, 0)
        XCTAssertEqual(mockView.retrievedError, "test_CharacterList_Failure")
    }
}
