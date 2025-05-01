//
//  CharacterCell.swift
//  Marvel Comic
//
//  Created by Kevin Costa on 30/8/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

import UIKit
import SwiftUI

class CharacterCell: UITableViewCell {
    
    // MARK: Variables
    
    private var controller: UIViewController!
    private var character: Character!
    
    // MARK: - METHODS
    
    func configure(with character: Character) {
        let characterView = CharacterView(character: character)
        guard let view = UIHostingController(rootView: characterView).view else {
            return
        }
        
        if let subView = contentView.subviews.first {
            subView.removeFromSuperview()
        }
        contentView.addToParent(view)
        selectionStyle = .none
    }
    
}
