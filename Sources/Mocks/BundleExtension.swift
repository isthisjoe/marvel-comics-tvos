import Foundation

class CurrentBundleFinder {}
extension Foundation.Bundle {
    public static var mocksModule: Bundle = {
        let bundleName = "MarvelComics_Mocks"
        let candidates = [
            Bundle.main.resourceURL,
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            Bundle.main.bundleURL,
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
