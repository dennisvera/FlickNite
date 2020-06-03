//
//  APIClient.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation
import CocoaLumberjack

final class APIClient {
  
  // MARK: - Initializer
  
  init() { }
  
  // MARK: - Public API
  
  func fetchMovies(_ completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    // Create and Initiate Data Task
    URLSession.shared.dataTask(with: request(for: .now_playing)) { (data, response, error) in
      if let data = data {
        do {
          // Initialize JSON Decoder
          let decoder = JSONDecoder()
          
          // Configure JSON Decoder
          decoder.dateDecodingStrategy = .iso8601
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          
          // Decode JSON Response
          let movies = try decoder.decode(MovieResponse.self, from: data)
          
          completion(.success(movies))
          
        } catch {
          completion(.failure(.invalidResponse))
        }
      } else {
        completion(.failure(.requestFailed))
        
        if let error = error {
          DDLogError("Unable to fetch Movies: \(error)")
        } else {
          DDLogError("Unable to fetch Movies")
        }
      }
    }.resume()
  }
}

extension APIClient {
  
  // MARK: - Types
  
  private enum QueryItem: String {
    
    // MARK: - Cases
    
    case apiKey = "2631ea46e7edd7894cf3eaee7d263667"
    case language = "en-US"
    case page = "1"
  }
  
  // MARK: - Helper Methods
  
  private func request(for endpoint: APIEndpoint) -> URLRequest {
    // Create and Configure URL
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.themoviedb.org"
    components.path = "/3/movie/\(endpoint.path)"
    components.queryItems = [
      URLQueryItem(name: "api_key", value: QueryItem.apiKey.rawValue),
      URLQueryItem(name: "language", value: QueryItem.language.rawValue),
      URLQueryItem(name: "page", value: QueryItem.page.rawValue)
    ]
    
    guard let url = components.url else { fatalError("Unable to compose URL.") }
    
    // Create Request
    let request = URLRequest(url: url)
    
    return request
  }
}
