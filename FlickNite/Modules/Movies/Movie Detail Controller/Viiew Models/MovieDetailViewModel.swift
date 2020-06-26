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
  
  var posterPath: String {
    return movie.posterPath ?? ""
  }
  
  // MARK: - Initialization
  
  init(movie: Movie) {
    self.movie = movie
  }
  
}
