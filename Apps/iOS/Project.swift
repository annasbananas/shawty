import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  name: "iOS",
  productName: "Shawty",
  platform: .iOS,
  dependencies: [
    .foundation("Core"),
    .foundation("UI"),
    .feature("Artist"),
    .feature("Shared"),
    .featureIOS("Artist"),
  ]
)
