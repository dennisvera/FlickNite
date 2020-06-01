//
//  NowPlayingViewModel.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

final class NowPlayingViewModel {
  
  // MARK: - Properties
  
  private let apiClient: APIClient
  
  // MARK: - Initialization
  
  init(apiClient: APIClient) {
    self.apiClient = apiClient
    
    // Fetch Movies
    APIClient().fetchMovies { result in
      switch result {
      case .success(let movies):
        print(movies.results[0].title)
      case .failure(let error):
        print(error)
      }
    }
  }
}
