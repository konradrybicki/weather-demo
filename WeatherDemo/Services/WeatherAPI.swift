import Foundation

enum WeatherAPIError: String, Error {
    case url = "Bad url"
    case data = "No data"
    case decoding = "Decoding error"
}

struct WeatherAPI {
    static func getData<T>(fromUrl wrappedUrl: URL?, completion: @escaping (Result<T,WeatherAPIError>)->Void) where T: Decodable {
        guard let url = wrappedUrl else {
            let error: WeatherAPIError = .url
            Logger.log(message: error.rawValue, logLevel: .error)
            completion(.failure(error))
            return
        }
        URLSession.performDataTask(with: url) { wrappedData, _, error in
            guard let data = wrappedData, error == nil else {
                let error: WeatherAPIError = .data
                Logger.log(message: error.rawValue, logLevel: .error)
                completion(.failure(error))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch(let exception) {
                let error: WeatherAPIError = .decoding
                Logger.log(message: "\(error.rawValue) (\(exception.localizedDescription))", logLevel: .error)
                completion(.failure(error))
            }
        }
    }
}
