import CharacterComics
import Mocks
import Models
import Services
import SwiftUI
import SwiftUIHelpers

public struct MarvelCharactersView: View {
  @ObservedObject public private(set) var viewModel: MarvelCharactersViewModel
  
  public init(viewModel: MarvelCharactersViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    NavigationView {
      ZStack {
        navigationDestination
        marvelCharacters
      }
      .onLoad {
        viewModel.loadMarvelCharacters()
      }
    }
  }
}

extension MarvelCharactersView {
  var navigationDestination: some View {
    NavigationLink(
      isActive: Binding(
        get: { self.viewModel.destination != nil },
        set: { isActive in
          if !isActive {
            self.viewModel.resetDestination()
          }
        }
      ),
      destination: {
        switch viewModel.destination {
        case let .characterComics(viewModel):
          CharacterComicsView(viewModel: viewModel)
        case .none:
          EmptyView()
        }
      },
      label: { EmptyView() }
    )
    .disabled(true)
    .buttonStyle(.plain)
  }
}

extension MarvelCharactersView {
  var marvelCharacters: some View {
    VStack {
      switch viewModel.marvelCharacters {
      case .none:
        EmptyView()
      case .loading:
        ProgressView()
      case let .completed(result):
        completedResult(result)
      case let .error(message):
        Text(message)
          .font(Fonts.titleFont)
      }
    }
  }
  
  func completedResult(_ characters: [MarvelCharacter]) -> some View {
    ScrollView(.horizontal) {
      LazyHStack(alignment: .center, spacing: 40) {
        ForEach(characters) { character in
          MarvelCharacterItemView(
            marvelCharacter: character,
            buttonTapped: {
              viewModel.characterTapped(character)
            }
          )
          .onAppear {
            viewModel.characterAppeared(character)
          }
        }
      }
    }
  }
}

#Preview {
  MarvelCharactersView(
    viewModel: MarvelCharactersViewModel(
      services: Services.mock
    )
  )
}
