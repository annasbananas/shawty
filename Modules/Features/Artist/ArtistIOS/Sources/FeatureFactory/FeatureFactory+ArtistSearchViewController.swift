import Artist
import Shared
import SharedIOS
import UIKit

extension FeatureFactory {
  public func makeArtistSearchViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    let url = ArtistEndpoint.search.url(baseURL: baseURL)

    let remoteArtistSearchLoader = RemoteArtistSearchLoader(
      url: url,
      client: httpClient
    )

    let imageDataLoadingImageAdapter = ImageDataLoadingImageAdapter(
      imageDataLoader: imageLoader,
      dataImageAdapter: UIImage.init(data:)
    )

    // Makes [ListCellVieModel] from [Artist]
    let artistsListCellViewModelAdapter = ArtistImageTitleRowViewModelAdapter(
      artistsSearchLoader: remoteArtistSearchLoader,
      imageDataLoadingImageAdapter: imageDataLoadingImageAdapter
    )

    let searchViewModel = SearchViewModel(
      promptText: ArtistIOSStrings.artistSearchPrompt
    )

    // Makes calls loader on search term update and creates ContentViewStream<[ListCellVieModel]> from [Artist]
    let contentStreamAdapter = PublishedQueryContentStreamAdapter(
      queryPublisher: searchViewModel
        .searchTextPublisher()
        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher(),
      loader: artistsListCellViewModelAdapter
    )

    let listViewModel = ArtistSearchListViewModel(
      screenTitle: ArtistIOSStrings.artistSearchScreenTitle,
      shouldCancelTasksOnDisappear: false,
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onArtistSelection
    )

    return ArtistSearchListViewController(
      searchViewModel: searchViewModel,
      listViewModel: listViewModel
    )
  }
}

extension String: QueryValidating {
  public func isValid() -> Bool {
    !isEmpty
  }
}