import Mocks
import Models
import SwiftUI
import SwiftUIHelpers

struct ComicItemView: View {
  @StateObject var viewModel: ComicItemViewModel
  
  var body: some View {
    Button {
      viewModel.buttonTapped()
    } label: {
      VStack(alignment: .leading, spacing: 0) {
        AsyncImageView(url: self.viewModel.comic.thumbnailUrl)
          .frame(width: 200, height: 303)
          .clipped()
        
        HStack {
          Text(self.viewModel.title.uppercased())
            .font(Fonts.titleFont)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .padding([.top, .bottom], 10)
          Spacer()
        }
        Text(self.viewModel.issueText)
          .font(Fonts.bodyFont)
          .foregroundColor(Color.gray)
          .padding(.bottom, 5)
        
        Text(self.viewModel.onsaleDate)
          .font(Fonts.bodyFont)
          .foregroundColor(Color.gray)
          .padding(.bottom, 10)
      }
      .frame(width: 200, height: 460)
      .padding(20)
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  ComicItemView(
    viewModel: ComicItemViewModel(
      comic: try! Comic.mock,
      buttonTapped: {}
    )
  )
}
