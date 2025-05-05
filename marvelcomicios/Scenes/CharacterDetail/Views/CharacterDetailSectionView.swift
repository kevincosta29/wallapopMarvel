//
//  CharacterDetailSectionView.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 5/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import SwiftUI

struct CharacterDetailSectionView: View {
    let title: String
    let items: [SectionItem]
    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                     ForEach(items, id: \.id) { item in
                          CharacterDetailSectionItemView(model: item)
                     }
                }
            }
            
        }
    }
}

struct SectionItem {
    let id = UUID()
    let urlImage: URL?
    let title: String?
}
