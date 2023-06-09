import SharedIOS
import SwiftUI
import Track

public enum TrackListUIComposer {
  private typealias TrackContentStreamLoader = () -> ContentViewStream<[TrackRowModel<Int>]>

  public static func listComposedWith(
    tracksLoader: any TracksLoader,
    selection: @escaping (Int) -> Void
  ) -> some View {
    let viewModel = ListViewModel(
      sectionTitle: TrackIOSStrings.trackListScreenTitle,
      contentLoader: tracksContentStreamLoader(
        tracksLoader: tracksLoader
      ),
      onItemSelection: selection
    )

    return TrackListView(
      viewModel: viewModel
    ) { rowModel in
      TrackRowView(model: rowModel)
    }
  }

  public static func listComposedWith(
    tracksLoader: any TracksLoader,
    selection: @escaping (Int) -> Void
  ) -> UIViewController {
    let viewModel = ListViewModel(
      contentLoader: tracksContentStreamLoader(
        tracksLoader: tracksLoader
      ),
      onItemSelection: selection
    )

    return TrackListViewController(
      screenTitle: TrackIOSStrings.trackListScreenTitle,
      listViewModel: viewModel
    )
  }

  private static func tracksContentStreamLoader(
    tracksLoader: any TracksLoader
  ) -> TrackContentStreamLoader {
    let trackListViewAdapter = TrackListViewAdapter(
      tracksLoader: tracksLoader
    )

    return ValueLoaderContentStreamAdapter(
      loader: trackListViewAdapter
    ).load
  }
}
