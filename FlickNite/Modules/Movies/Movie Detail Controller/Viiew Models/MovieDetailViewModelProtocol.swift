//
//  MovieDetailViewModelProtocol.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/26/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

/// Protocol which defines the variables / functions for the MovieDetailViewModel.
protocol MovieDetailViewModelProtocol: class {

  /// The movie model that contains all of the Movie properties
  var movie: Movie { get }
  
  /// An array of video objects containing all videos and their properties
  var video: [Video] { get }
  
  /// The Network Client for making API calls
  var apiClient: FlickNiteAPIClient { get }
  
  /// Closure for handling play movie trailer button
  var didTapPlayButton: ((String) -> Void)? { get }
  
  /// The movie backdrop path for displaying movie poster
  var backdropPath: String { get }
  
  /// Method that calls the API Client to fetch movie details
  func fetchMovieTrailer()
  
  /// Public facing method that calls the didTapPlayButton closure
  func showMovieTrailer()
}
