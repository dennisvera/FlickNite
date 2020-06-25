//
//  FlickNiteAPIClient.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation
import CocoaLumberjack

final class FlickNiteAPIClient: APIClient {
  
  // MARK: - Initializer
  
  init() {}
  
  // MARK: - Public API
  
  func fetchMovies(pageIndex: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    guard let urlString = APIEndpoint.getMovies(pageIndex: pageIndex).url?.absoluteString else { return }
    
    fetchGenericJsonData(with: urlString, completion: completion)
  }
  
  func fechMovieTrailer(with id: Int, completion: @escaping (Result<VideoResponse, APIError>) -> Void) {
    guard let urlString = APIEndpoint.getMovieVideo(id: id).url?.absoluteString else { return }
    
    fetchGenericJsonData(with: urlString, completion: completion)
  }
  
  // MARK: - Helper Method
  
  private func fetchGenericJsonData<T: Decodable>(with urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
    guard let url = URL(string: urlString) else { return }
    
    // Create and Initiate Data Task
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data {
        do {
          // Initialize JSON Decoder
          let decoder = JSONDecoder()
          
          // Configure JSON Decoder
          decoder.dateDecodingStrategy = .iso8601
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          
          // Decode JSON Response
          let response = try decoder.decode(T.self, from: data)
          
          // Invoke Handler
          completion(.success(response))
        } catch {
          // Invoke Handler
          completion(.failure(.invalidResponse))
        }
        
      } else {
        // Invoke Handler
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
