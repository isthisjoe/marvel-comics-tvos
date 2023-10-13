import App
import Services
import SwiftUI

@main
struct MarvelComicsApp: App {
  var body: some Scene {
    WindowGroup {
      AppView(
        viewModel: AppViewModel(
          services: Services.live
        )
      )
    }
  }
}
