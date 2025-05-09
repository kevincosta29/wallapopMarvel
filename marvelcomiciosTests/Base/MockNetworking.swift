//
//  MockNetworking.swift
//  marvelcomiciosTests
//
//  Created by Kevin Costa on 9/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import Foundation

struct MockNetworking {
    static var urlSession: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
