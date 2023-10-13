import Services
import SwiftUI

public final class AppViewModel: ObservableObject {
  let services: Services
  
  public init(services: Services) {
    self.services = services
  }
}
