import Foundation

extension URL {
    static func forJson(fileName: String) -> Self? {
        Bundle.main.url(forResource: fileName, withExtension: "json")
    }
}
