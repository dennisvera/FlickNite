//
//  MockClient.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

/**
 The `MockClient` class can be used to locally
 test the FlickNite application without
 the need for a local server.
 */

import Foundation

final class MockClient: APIClient {
  
  // MARK: - API Client
  
  func fetchMovies(pageIndex: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
    // Find Mock Response
    guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
      fatalError("Unable to Find Mock Response")
    }
    
    // Load Mock Response
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Unable to Load Mock Response")
    }
    
    // Initialize JSON Decoder
    let decoder = JSONDecoder()
    
    // Configure JSON Decoder
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    // Decode JSON Response
    guard let episodes = try? decoder.decode(MovieResponse.self, from: data) else {
      fatalError("Unable to Decode Mock Response")
    }
    
    // Invoke Handler
    completion(.success(episodes))
  }
}
