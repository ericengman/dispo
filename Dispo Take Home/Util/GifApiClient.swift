import UIKit

class GifAPIClient {
  // TODO: Implement
    static let shared = GifAPIClient()
    private var session: URLSessionDataTask!
    
    private enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func getGifs<T: Codable>(newSession: Bool, url: URL?, type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        if newSession && session != nil { session.cancel() } // Cancel any current calls
        
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        session = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            }
            catch {
                print("Data couldn't be decoded")
                completion(.failure(error))
            }
        }
        session.resume()
    }
    
}
