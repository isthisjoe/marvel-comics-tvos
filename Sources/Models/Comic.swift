import Foundation

public final class Comic: Codable, Identifiable, ObservableObject {
  private struct Thumbnail: Codable, Equatable {
    let path: String
    let `extension`: String
  }
  
  private struct ComicDate: Codable, Equatable {
    fileprivate enum DateType: String, Codable, Equatable {
      case onsaleDate
      case focDate
      case unlimitedDate
      case digitalPurchaseDate
    }
    
    fileprivate let type: DateType
    fileprivate let date: Date
  }
  
  public let id: Int
  public let title: String
  public let issueNumber: Double
  private let dates: [ComicDate]
  private let thumbnail: Thumbnail
}

extension Comic: Equatable {
  public static func == (lhs: Comic, rhs: Comic) -> Bool {
    lhs.id == rhs.id
  }
}

extension Comic {
  public var thumbnailUrl: URL? {
    URL(string: "\(self.thumbnail.path).\(self.thumbnail.extension)")
  }
  
  public var onsaleDate: Date? {
    self.dates.first(where: { $0.type == .onsaleDate })?.date
  }
}
