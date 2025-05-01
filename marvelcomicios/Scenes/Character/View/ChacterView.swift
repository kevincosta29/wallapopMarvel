import Kingfisher
import SwiftUI

struct CharacterView: View {
    let character: Character
    var body: some View {
        HStack(spacing: 10) {
            if let url = character.thumbnail?.urlImg {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .topLeading)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            VStack(spacing: 4) {
                if let name = character.name {
                    Text(name)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                }
                if let description = character.description {
                    Text(description)
                        .font(.callout)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(4)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding([.horizontal, .vertical], 16)
    }
}

#Preview {
    CharacterView(character: Character(
        id: 1, name: "Lorem Ipsum",
        description: "Lorem Ipsum",
        modified: nil,
        thumbnail: nil,
        urls: nil)
    )
}
