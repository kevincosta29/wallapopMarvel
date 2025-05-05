//
//  CharacterDetailFlowManager.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 12/7/22.
//  Copyright © 2022 Kevin Costa. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterDetailFlowManagerProtocol {
    func goToWebView(url: URL, title: String)
}

class CharacterDetailFlowManager: CharacterDetailFlowManagerProtocol {
    
    // MARK: VARIABLES
    
    weak var viewController: UIViewController?
    
    // MARK: - METHODS
    
    func goToWebView(url: URL, title: String) {
        let webView = WebViewC(url: url, strTitle: title)
        viewController?.navigationController?.pushViewController(webView, animated: true)
    }
    
}
