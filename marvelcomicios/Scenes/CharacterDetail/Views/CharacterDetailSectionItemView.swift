//
//  CharacterDetailSectionItemView.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 5/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import SwiftUI
import Kingfisher

struct CharacterDetailSectionItemView: View {
    let model: SectionItem
    
    var body: some View {
        VStack {
            if let urlImage = model.urlImage {
                KFImage(urlImage)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }
            
            Text(model.title ?? "")
                .font(.callout)
                .fontWeight(.thin)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
        }
        .frame(width: 150)
        
    }
}
