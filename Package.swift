// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "MarvelComics",
  platforms: [
    .iOS(.v14),
    .tvOS(.v14)
  ],
  products: [
    .library(
      name: "App",
      targets: ["App"]
    ),
    .library(
      name: "CharacterComics",
      targets: ["CharacterComics"]
    ),
    .library(
      name: "FoundationHelpers",
      targets: ["FoundationHelpers"]
    ),
    .library(
      name: "Logs",
      targets: ["Logs"]
    ),
    .library(
      name: "MarvelApiClient",
      targets: ["MarvelApiClient"]
    ),
    .library(
      name: "MarvelCharacters",
      targets: ["MarvelCharacters"]
    ),
    .library(
      name: "Mocks",
      targets: ["Mocks"]
    ),
    .library(
      name: "Models",
      targets: ["Models"]
    ),
    .library(
      name: "Services",
      targets: ["Services"]
    ),
    .library(
      name: "SwiftUIHelpers",
      targets: ["SwiftUIHelpers"]
    )
  ],
  targets: [
    .target(
      name: "App",
      dependencies: [
        "MarvelCharacters",
        "Services"
      ]
    ),
    .target(
      name: "CharacterComics",
      dependencies: [
        "FoundationHelpers",
        "Logs",
        "MarvelApiClient",
        "Mocks",
        "Models",
        "Services",
        "SwiftUIHelpers"
      ]
    ),
    .target(
      name: "FoundationHelpers"
    ),
    .target(
      name: "Logs"
    ),
    .target(
      name: "MarvelApiClient"
    ),
    .target(
      name: "MarvelCharacters",
      dependencies: [
        "CharacterComics",
        "FoundationHelpers",
        "Logs",
        "MarvelApiClient",
        "Mocks",
        "Models",
        "Services",
        "SwiftUIHelpers"
      ]
    ),
    .target(
      name: "Mocks",
      dependencies: [
        "FoundationHelpers",
        "Models"
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "Models"
    ),
    .target(
      name: "Services",
      dependencies: [
        "FoundationHelpers",
        "MarvelApiClient",
        "Models",
        "Mocks"
      ]
    ),
    .target(
      name: "SwiftUIHelpers"
    ),
    
    /*
     Test Targets
     */
    .testTarget(
      name: "AppTests",
      dependencies: [
        "App"
      ]
    ),
    .testTarget(
      name: "CharacterComicsTests",
      dependencies: [
        "CharacterComics",
        "Models",
        "Services"
      ]
    ),
    .testTarget(
      name: "ModelsTests",
      dependencies: [
        "Mocks",
        "Models"
      ]
    ),
    .testTarget(
      name: "MarvelCharactersTests",
      dependencies: [
        "MarvelCharacters",
        "Models",
        "Services"
      ]
    )
  ]
)
