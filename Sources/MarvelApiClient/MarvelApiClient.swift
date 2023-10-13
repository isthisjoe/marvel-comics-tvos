import Foundation

public struct MarvelApiClient {
  public private(set) var apiRequest: (Route) async throws -> Data
  
  public init(
    apiRequest: @escaping @Sendable (Route) async throws -> Data
  ) {
    self.apiRequest = apiRequest
  }
}


