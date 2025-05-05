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
    func openModal(arrayLinks: [Link])
}

class CharacterDetailFlowManager: NSObject, CharacterDetailFlowManagerProtocol {
    
    // MARK: VARIABLES
    
    weak var viewController: UIViewController?
    
    // MARK: - METHODS
    
    func goToWebView(url: URL, title: String) {
        let webView = WebViewC(url: url, strTitle: title)
        viewController?.navigationController?.pushViewController(webView, animated: true)
    }
    
    func openModal(arrayLinks: [Link]) {
        let modalList = ModalListC(arrayLinks: arrayLinks, flowManager: self)
        modalList.modalPresentationStyle = .custom
        modalList.transitioningDelegate = self
        viewController?.navigationController?.present(modalList, animated: true)
    }
}

extension CharacterDetailFlowManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

