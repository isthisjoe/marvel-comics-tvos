import Models
import SwiftUI
import SwiftUIHelpers

struct MarvelCharacterItemView: View {
  private(set) var marvelCharacter: MarvelCharacter
  let buttonTapped: () -> Void
  
  var body: some View {
    Button {
      buttonTapped()
    } label: {
      VStack(spacing: 20) {
        AsyncImageView(url: self.marvelCharacter.thumbnailUrl)
          .frame(width: 200, height: 200)
          .clipShape(Circle())
        
        Text(" \n ")
          .font(Fonts.titleFont)
          .frame(maxWidth: .infinity)
          .overlay(
            Text(marvelCharacter.name.uppercased())
              .font(Fonts.titleFont)
              .multilineTextAlignment(.center),
            alignment: .top
          )
      }
      .padding(20)
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  MarvelCharacterItemView(
    marvelCharacter: try! MarvelCharacter.mock,
    buttonTapped: {}
  )
}
