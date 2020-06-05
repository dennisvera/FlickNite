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
  
  private let apiClient: FlickNiteAPIClient
  
  private var movies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.moviesDidChange?()
      }
    }
  }
    
   // MARK: - Public API
  
  var moviesDidChange: (() -> Void)?
  
  var numberOfMovies: Int {
    return movies.count
  }
  
  // MARK: - Initialization
  
  init(apiClient: FlickNiteAPIClient) {
    self.apiClient = apiClient
    
    fetchMovies()
  }
  
  // MARK: - Helper Methods
  
  private func fetchMovies() {
    // Fetch Movies
    apiClient.fetchMovies { [weak self] result in
      switch result {
      case .success(let movies):
        guard let strongSelf = self else { return }
        strongSelf.movies = movies.results
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func movies(at index: Int) -> Movie {
    return movies[index]
  }
  
  // MARK: - Public API
  
  func presentabble(for index: Int) -> NowPlayingPresentable {
    movies(at: index)
  }
}
