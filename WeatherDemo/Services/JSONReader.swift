import Foundation

enum JSONReaderError: String, Error {
    case file = "No such file"
    case data = "No data"
    case decoding = "Decoding error"
}

final class JSONReader {
    static func read<T>(fromFile fileName: String) throws -> T where T: Decodable {
        guard let url = URL.forJson(fileName: fileName) else {
            let error: JSONReaderError = .file
            Logger.log(message: error.rawValue, logLevel: .error)
            throw error
        }
        guard let data = try? Data(contentsOf: url) else {
            let error: JSONReaderError = .data
            Logger.log(message: error.rawValue, logLevel: .error)
            throw error
        }
        let fileContent: T
        do {
            fileContent = try JSONDecoder().decode(T.self, from: data)
        } catch(let exception) {
            let error: JSONReaderError = .decoding
            Logger.log(message: "\(error.rawValue) (\(exception.localizedDescription))" , logLevel: .error)
            throw error
        }
        return fileContent
    }
}
