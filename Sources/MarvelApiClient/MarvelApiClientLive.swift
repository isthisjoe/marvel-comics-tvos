import CryptoKit
import Foundation

public extension MarvelApiClient {
  static let baseApiUrl = "https://gateway.marvel.com:443/v1/public"
  
  static var live: MarvelApiClient {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    return MarvelApiClient(
      apiRequest: { route in
        guard let url = url(with: route) else {
          throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = route.method
        let (data, _) = try await session.data(from: url)
        return data
      }
    )
  }
  
  private static func url(with route: Route) -> URL? {
    URL(string: "\(Self.baseApiUrl)/\(route.path)?\(authenticationParameters)&\(route.queryParameters)")
  }
  
  private static func md5Hash(_ source: String) -> String {
    Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
  }

  private static var authenticationParameters: String {
    let timestamp: String
    if #available(tvOS 15.0, *) {
      timestamp = Date().ISO8601Format()
    } else {
      timestamp = ISO8601DateFormatter().string(from: Date())
    }
    let privateKey = "b72dba6f8c2e69ecaf6f25b26c49b374e7dab9c1"
    let publicKey = "d60884811f11f9b757b99f34a419511f"
    return "apikey=\(publicKey)&ts=\(timestamp)&hash=\(md5Hash(timestamp + privateKey + publicKey))"
  }
}
