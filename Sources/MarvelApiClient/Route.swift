public enum Route {
  case characters(offset: Int, limit: Int)
  case characterComics(id: Int, offset: Int, limit: Int)
}

extension Route {
  var path: String {
    switch self {
    case .characters:
      "characters"
    case let .characterComics(id, _, _):
      "characters/\(id)/comics"
    }
  }

  var queryParameters: String {
    switch self {
    case let .characters(offset, limit):
      "offset=\(offset)&limit=\(limit)"
    case let .characterComics(_, offset, limit):
      "offset=\(offset)&limit=\(limit)"
    }
  }
  
  var method: String {
    switch self {
    case .characters:
      "GET"
    case .characterComics:
      "GET"
    }
  }
}
