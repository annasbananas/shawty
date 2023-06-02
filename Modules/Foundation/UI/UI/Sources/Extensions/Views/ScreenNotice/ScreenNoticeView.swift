import SwiftUI

public struct ScreenNoticeView: View {
  private let model: ScreenNoticeModel

  public init(model: ScreenNoticeModel) {
    self.model = model
  }

  public var body: some View {
    VStack(spacing: 5) {
      iconView
      Spacer().frame(height: 10)
      titleView
      subtitleView
    }
    .opacity(model.style.opacity)
  }

  private var titleView: some View {
    Text(model.title)
      .font(.headline)
  }

  @ViewBuilder private var subtitleView: some View {
    if let subtitle = model.subtitle {
      Text(subtitle)
        .font(.subheadline)
        .foregroundColor(model.iconColor)
    }
  }

  private var iconView: some View {
    model.icon.asSystemImage()
      .font(.system(size: 50))
      .foregroundColor(model.iconColor)
  }

}