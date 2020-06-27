//
//  MovieDetailViewModel.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/26/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

/// The view model for the Movie Detail view controller.
final class MovieDetailViewModel: MovieDetailViewModelProtocol {
  
  // MARK: - Properties
  
  let movie: Movie
  let apiClient: FlickNiteAPIClient
  
  var video: [Video] = []
  
  var didTapPlayButton: ((String) -> Void)?
  
  var backdropPath: String {
    return movie.backdropPath ?? ""
  }
  
  var posterPath: String {
    return movie.posterPath ?? ""
  }
  
  var videoId: String {
    return video.first?.key ?? ""
  }
  
  // MARK: - Initialization
  
  init(apiClient: FlickNiteAPIClient, movie: Movie) {
    self.apiClient = apiClient
    self.movie = movie
    
    fetchMovieTrailer()
  }
  
  // MARK: - Helper Methods
  
  func fetchMovieTrailer() {
    apiClient.fechMovieTrailer(with: movie.id) { [weak self] result in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let movie):
        strongSelf.video.append(contentsOf: movie.results)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // MARK: - Public API Methods
  
  func showMovieTrailer() {
    didTapPlayButton?(videoId)
  }
}
