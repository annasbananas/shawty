import SharedIOS
import SwiftUI

public final class AlbumListViewController: UIViewController {
  private let screenTitle: String
  private let listViewModel: AlbumListViewModel

  init(
    screenTitle: String,
    listViewModel: AlbumListViewModel
  ) {
    self.screenTitle = screenTitle
    self.listViewModel = listViewModel
    super.init(nibName: nil, bundle: nil)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    embed(albumListView())
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Album List View

extension AlbumListViewController {
  private func albumListView() -> some View {
    NavigationView {
      AlbumListView(
        viewModel: listViewModel
      ) { rowViewModel in
        ImageTitleRowView(viewModel: rowViewModel)
      }
      .navigationTitle(screenTitle)
      .navigationBarTitleDisplayMode(.automatic)
    }
  }
}
