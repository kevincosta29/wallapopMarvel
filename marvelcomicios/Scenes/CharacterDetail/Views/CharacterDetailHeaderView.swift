//
//  CharacterDetailHeaderView.swift
//  marvelcomicios
//
//  Created by Kevin Costa on 5/5/25.
//  Copyright © 2025 Kevin Costa. All rights reserved.
//

import SwiftUI
import Kingfisher

struct CharacterDetailHeaderView: View {
    let urlImage: URL?
    let title: String?
    let description: String?
    var body: some View {
        VStack(spacing: 10) {
            if let urlImage {
                KFImage(urlImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
            }
            
            if let title {
                Text(title)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            }
            
            if let description {
                Text(description)
                    .font(.callout)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            }
        }
    }
}
