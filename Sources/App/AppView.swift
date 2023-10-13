import MarvelCharacters
import SwiftUI

public struct AppView: View {
  @ObservedObject private var viewModel: AppViewModel
  
  public init(viewModel: AppViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    MarvelCharactersView(
      viewModel: MarvelCharactersViewModel(
        services: viewModel.services
      )
    )
  }
}

