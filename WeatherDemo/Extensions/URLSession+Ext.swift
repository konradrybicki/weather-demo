import Foundation

extension URLSession {
    static func performDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?)->Void) {
        self.init(configuration: .default).dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
