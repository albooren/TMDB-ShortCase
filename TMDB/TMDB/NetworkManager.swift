//
//  NetworkManager.swift
//  TMDB
//
//  Created by Alperen Kişi on 19.06.2022.
//

import Foundation

typealias RequestCompletion<T> = (Result<T, Error>) -> Void


enum Endpoints : String {
    case nowPlaying = "/3/movie/now_playing"
    case upComing = "/3/movie/upcoming"
    case detail = "/3/movie"
}
enum HTTPMethods: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
}


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(url: URL?, requestMethod: HTTPMethods, onComplete: @escaping RequestCompletion<T>) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        let task = URLSession.shared
        task.dataTask(with: request) { (data, response, error) in
            guard let remoteData = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: remoteData)
                onComplete(.success(decodedData))
            } catch {
                onComplete(.failure(error))
            }
        }.resume()
    }
    
    
    
    func getURL(with endpoint:String) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.themoviedb.org"
            components.path = endpoint
            components.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: "993fd1ddf77f9e1dc0979c295296959d")
            ]
        return components.url
        }

    func getImageURL(with imageURL:String ) -> URL? {
    let baseURL = "https://image.tmdb.org/t/p/original"
        return URL(string: baseURL + imageURL)
    }
}
