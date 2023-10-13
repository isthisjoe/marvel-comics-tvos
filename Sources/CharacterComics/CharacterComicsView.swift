import Mocks
import Models
import Services
import SwiftUI
import SwiftUIHelpers

public struct CharacterComicsView: View {
  @ObservedObject var viewModel: CharacterComicsViewModel
  
  public init(viewModel: CharacterComicsViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack(alignment: .bottom) {
      characterBackground
      comics
    }
    .onLoad {
      Task {
        await self.viewModel.loadComics()
      }
    }
  }
}

extension CharacterComicsView {
  var characterBackground: some View {
    GeometryReader { geometryProxy in
      HStack(spacing: 0) {
        VStack {
          AsyncImageView(url: viewModel.characterThumbnailUrl)
            .frame(
              width: geometryProxy.size.height,
              height: geometryProxy.size.height
            )
            .offset(y: -geometryProxy.size.height * 0.1)
        }
        .overlay(
          LinearGradient(
            gradient: Gradient(colors: [.clear, .black]),
            startPoint: .center,
            endPoint: .bottom
          )
        )
        .overlay(
          LinearGradient(
            gradient: Gradient(colors: [.clear, .black]),
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        
        Text(viewModel.characterName.uppercased())
          .font(Fonts.largeTitleFont)
          .foregroundColor(Color.white)
          .padding([.bottom, .leading], 40)
        Spacer()
      }
      .frame(
        height: geometryProxy.size.height / 2
      )
    }
  }
}

extension CharacterComicsView {
  var comics: some View {
    VStack {
      switch viewModel.comics {
      case .none:
        EmptyView()
      case .loading:
        loading
      case let .completed(result):
        completedResult(result)
      case let .error(message):
        error(message)
      }
    }
  }
  
  func completedResult(_ comics: [Comic]) -> some View {
    GeometryReader { geometryProxy in
      VStack {
        Spacer()
        ScrollView(.horizontal) {
          LazyHStack(alignment: .center, spacing: 40) {
            ForEach(comics) { comic in
              ComicItemView(
                viewModel: ComicItemViewModel(
                  comic: comic,
                  buttonTapped: {}
                )
              )
              .onAppear {
                Task {
                  await self.viewModel.comicAppeared(comic)
                }
              }
            }
          }
        }
        .frame(height: geometryProxy.size.height * 2 / 3)
      }
    }
  }  
  
  var loading: some View {
    GeometryReader { geometryProxy in
      VStack {
        Spacer()
        HStack {
          Spacer()
          ProgressView()
          Spacer()
        }
      }
      .frame(height: geometryProxy.size.height * 2 / 3)
    }
  }
  
  func error(_ message: String) -> some View {
    GeometryReader { geometryProxy in
      VStack {
        Spacer()
        HStack {
          Spacer()
          Text(message)
            .font(Fonts.titleFont)
          Spacer()
        }
      }
      .frame(height: geometryProxy.size.height * 2 / 3)
    }
  }
}

#Preview {
  CharacterComicsView(
    viewModel: CharacterComicsViewModel(
      character: try! MarvelCharacter.mock, 
      characterComicsService: CharacterComicsService.mock
    )
  )
}
