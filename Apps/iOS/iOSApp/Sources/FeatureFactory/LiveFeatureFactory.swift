import Networking
import Shared

final class LiveFeatureFactory: FeatureFactory {
  private init() { }

  fileprivate static let shared = LiveFeatureFactory()

  lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)

  lazy var imageLoader: any ImageDataLoader = RemoteImageDataLoader(client: httpClient)

  let baseURL = Config.baseURL
}

extension FeatureFactory where Self == LiveFeatureFactory {
  static var live: Self { .shared }
}
