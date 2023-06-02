import ProjectDescription
import ProjectDescriptionHelpers

let iOSIntegrationTests = Scheme(
  name: "IntegrationTests-iOS",
  testAction:
  .testPlans(
    [
      "TestPlans/IntegrationTests-iOS.xctestplan",
    ],
    attachDebugger: false
  )
)

let macOSIntegrationTests = Scheme(
  name: "IntegrationTests-macOS",
  testAction:
  .testPlans(
    [
      "TestPlans/IntegrationTests-macOS.xctestplan",
    ],
    attachDebugger: false
  )
)

let iOSUnitTests = Scheme(
  name: "UnitTests-iOS",
  testAction:
  .testPlans(
    [
      "TestPlans/UnitTests-iOS.xctestplan",
    ],
    attachDebugger: false
  )
)

let macOSUnitTests = Scheme(
  name: "UnitTests-macOS",
  testAction:
  .testPlans(
    [
      "TestPlans/UnitTests-macOS.xctestplan",
    ],
    attachDebugger: false
  )
)

let iOS = Scheme(
  name: "iOS",
  buildAction: .buildAction(
    targets: [
      .foundation("Core"),
      .foundation("UI"),
      .app("iOS"),
    ]
  ),
  runAction: .runAction(executable: .app("iOS"))
)

let workspace = Workspace(
  name: ProjectConfiguration.appName,
  projects: [
    "Apps/iOS",
  ],
  schemes: [
    macOSUnitTests,
    iOSUnitTests,
    iOSIntegrationTests,
    macOSIntegrationTests,
    iOS,
  ],
  fileHeaderTemplate: "",
  additionalFiles: [
    .folderReference(path: .relativeToRoot("TestPlans")),
  ], generationOptions: .options(
    enableAutomaticXcodeSchemes: false,
    autogeneratedWorkspaceSchemes: .disabled,
    lastXcodeUpgradeCheck: .init(14, 3, 0),
    renderMarkdownReadme: true
  )
)
