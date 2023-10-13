import SwiftUI

public struct AsyncImageView: View {
  let url: URL?
  
  public init(url: URL?) {
    self.url = url
  }
  
  public var body: some View {
    if #available(tvOS 15.0, *) {
      AsyncImage(url: self.url) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Color.gray
      }
    } else {
      // TODO: Backport AsyncImage for iOS 14 and below
      Text("AsyncImageView")
    }
  }
}

#Preview {
  AsyncImageView(
    url: URL(
      string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"
    )
  )
  .frame(width: 200, height: 200)
}
