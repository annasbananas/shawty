import Album
import AlbumIOS
import Artist
import SwiftUI
import UIKit

extension FeatureFactory: AlbumFactory {
  func makeAlbumListViewController(
    for albumID: Int,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    AlbumListUIComposer.listComposedWith(
      albumsLoader: makeRemoteAlbumsLoader(for: albumID),
      imageDataLoader: imageLoader,
      selection: onAlbumSelection
    )
  }

  func makeAlbumDetailViewController(
    for albumID: Int,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    AlbumDetailUIComposer.detailComposedWith(
      albumLoader: makeRemoteAlbumLoader(for: albumID),
      imageDataLoader: imageLoader,
      listView: { [unowned self] in
        makeTrackListView(
          for: albumID,
          onTrackSelection: onTrackSelection
        )
      }
    )
  }

  private func makeRemoteAlbumsLoader(for albumID: Int) -> any AlbumsLoader {
    RemoteAlbumsLoader(
      url: ArtistEndpoint.albums(id: albumID).url(baseURL: baseURL),
      client: httpClient
    )
  }

  private func makeRemoteAlbumLoader(for albumID: Int) -> any AlbumLoader {
    RemoteAlbumLoader(
      url: AlbumEndpoint.album(id: albumID).url(baseURL: baseURL),
      client: httpClient
    )
  }
}
