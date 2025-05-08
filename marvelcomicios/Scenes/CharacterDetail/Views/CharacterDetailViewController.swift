// 
//  CharacterDetailC.swift
//  Marvel Comic
//
//  Created by Kevin Costa on 30/8/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

protocol CharacterDetailViewInterface: AnyObject {
    func loadContent(series: [SectionItem], comics: [SectionItem])
    func toggleLoading()
    func showError(errorMessage: String)
}

final class CharacterDetailViewController: UIViewController {
    
	// MARK: VARIABLES
    private let presenter: CharacterDetailPresenterInterface
	
    private lazy var buttonRetry: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.Default.errorMessage, for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapButtonRetry)))
        button.isHidden = true
        return button
    }()
    private let loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.startAnimating()
        loading.style = .large
        loading.isHidden = true
        return loading
    }()
    private let mainContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
	
	//-----------------------
	// MARK: - LIVE APP
	//-----------------------
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
    init(presenter: CharacterDetailPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        configBackButton()
        configViews()
        
        presenter.viewReady()
	}
    
}

private extension CharacterDetailViewController {
    @objc func retrieveData() {
        presenter.retryLoad()
    }
    
    @objc func popController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapButtonRetry() {
        presenter.retryLoad()
    }
    
    func configViews() {
        let scrollView = UIScrollView()
        view.addToParent(scrollView)
        view.addToParent(loading)
        scrollView.addToParent(mainContainer)
        mainContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        mainContainer.isHidden = true
        view.backgroundColor = .white
    }
    
    func configBackButton() {
        let img = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        let btn = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(self.popController))
        navigationItem.leftBarButtonItem = btn
    }
}

extension CharacterDetailViewController: CharacterDetailViewInterface {
    func loadContent(series: [SectionItem], comics: [SectionItem]) {
        // Display all the content
        mainContainer.isHidden = false
        let viewHeader = CharacterDetailHeaderView(urlImage: presenter.character.thumbnail?.urlImg,
                                                   title: presenter.character.name,
                                                   description: presenter.character.description)
        if let viewContainer = UIHostingController(rootView: viewHeader).view {
            mainContainer.addArrangedSubview(viewContainer)
        }
        
        setupSection(title: Localization.CharacterDetail.sectionComics, items: comics)
        setupSection(title: Localization.CharacterDetail.sectionSeries, items: series)
    }
    
    func setupSection(title: String, items: [SectionItem]) {
        guard !items.isEmpty else {
            return
        }
        
        let section = CharacterDetailSectionView(title: title, items: items)
        if let viewContainer = UIHostingController(rootView: section).view {
            mainContainer.addArrangedSubview(viewContainer)
        }
    }
    
    func toggleLoading() {
        loading.isHidden = !loading.isHidden
    }
    
    func showError(errorMessage: String) {
        buttonRetry.setTitle(errorMessage, for: .normal)
        mainContainer.isHidden = true
    }
}
