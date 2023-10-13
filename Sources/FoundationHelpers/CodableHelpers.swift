import Foundation

extension JSONDecoder {
  public static var snakeCase: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
    return decoder
  }
}

extension JSONEncoder {
  public static var snakeCase: JSONEncoder {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601)
    return encoder
  }
}

extension Encodable {
  public func encode() throws -> Data {
    try JSONEncoder.snakeCase.encode(self)
  }
}

extension Data {
  public func decode<T: Decodable>() throws -> T {
    try JSONDecoder.snakeCase.decode(T.self, from: self)
  }
}
