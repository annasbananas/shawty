import AlbumIOS
import ArtistIOS
import Core
import Shared
import UIIOS
import UIKit

/// The Artist Search Scene, the launching feature of the app
final class ArtistSearchSceneCoordinator: Coordinator {
  public var childCoordinators = [Coordinator]()
  public let navigationController: UINavigationController
  private lazy var featureFactory = FeatureFactory.shared

  public init(
    with navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }

  public func start() {
    let coordinator = artistSearchCoordinator()
    addChild(coordinator)

    coordinator.delegate = WeakRefVirtualProxy(self)
    coordinator.start()
  }

  private func artistSearchCoordinator() -> ArtistSearchListCoordinator {
    featureFactory.makeArtistSearchListCoordinator(
      navigationController: navigationController,
      removeCoordinatorWith: removeChild(_:)
    )
  }
}

extension ArtistSearchSceneCoordinator: ArtistSearchCoordinatorDelegate {
  public func didSelectArtist(withID id: Int) {
    let coordinator = featureFactory.makeAlbumListCoordinator(
      for: id,
      navigationController: navigationController,
      removeCoordinatorWith: removeChild(_:)
    )

    addChild(coordinator)

    coordinator.delegate = WeakRefVirtualProxy(self)
    coordinator.start()
  }
}

extension ArtistSearchSceneCoordinator: AlbumListCoordinatorDelegate {
  // Simulating playing of a track
  func didSelectTrack(withID id: Int) {
    let alert = UIAlertController(
      title: "'Playing' Track",
      message: "Track ID: \(id)",
      preferredStyle: .alert
    )

    alert.addAction(
      UIAlertAction(
        title: "OK",
        style: .default
      )
    )

    navigationController.present(alert, animated: true)
  }
}
