# Marvel Comics tvOS App

This app uses the Marvel API to show a list of characters, and comics when a character is tapped.

## Getting Started

1. Launch the project via `MarvelComicsApp/MarvelComicsApp.xcodeproj`.
2. Select the `MarvelComicsApp` scheme and select the tvOS device.
3. To launch the app: `Product > Run`.
4. To run all tests: `Product > Test`.

## Architecture

The app uses MVVM with a service layer architecture:
- MVVM is used to separate UI from business logic via a View Model that is reactive, and the layer between the View and Model
- The Service layer contains domain-specific sub-layers that provides data and related services to the View Models

## SPM Modular Architecture

This project is hyper-modularized where each component is its package and defined in `Package.swift`. This allows one to run code in isolation, forces encapsulation, and improves build times when developing single features.

## Constraints

These are the constraints I decided when working on this project:
- Minimum deployment version is tvOS 14. This was the version the current ESPN tvOS at the time of development, so thought it best to keep within the same version.

## TDB

These are some missing requirements that I decided were out of scope and would implement if given more time:
- Persistance of model data. Use of Core Data would be ideal as it is stable and doesn't require third party libraries
- Backport AsyncImage to work on versions after tvOS 14.
- More code coverage - I only tested what I thought to be important tests. There are still some tests that would require extra code to perform correctly. For example the Service layer live API calls can't be tested unless a mock URLSession was developed.
