import Foundation
import Models

class ComicItemViewModel: ObservableObject {
  @Published var comic: Comic
  let buttonTapped: () -> Void
  let monthDayYearFormatter = DateFormatter.monthDayYear
  
  init(
    comic: Comic,
    buttonTapped: @escaping () -> Void
  ) {
    self.comic = comic
    self.buttonTapped = buttonTapped
  }
  
  var title: String {
    self.comic.title
  }
  
  var issueText: String {
    "Issue #\(self.comic.issueNumber)"
  }
  
  var onsaleDate: String {
    guard let onsaleDate = self.comic.onsaleDate else { return "" }
    return self.monthDayYearFormatter.string(from: onsaleDate)
  }
}
