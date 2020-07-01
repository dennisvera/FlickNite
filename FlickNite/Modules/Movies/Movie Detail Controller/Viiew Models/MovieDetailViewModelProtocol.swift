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
  
  /// The Network Client for making API calls
  var apiClient: FlickNiteAPIClient { get }
  
  /// An array of video objects containing all videos and their properties
  var video: [Video] { get }
  
  /// The Movie Title
  var title: String { get }
  
  /// The Movie Release Date
  var releaseDate: String { get }
  
  /// The Movie Popularity Score
  var popularityScore: String { get }
  
  /// The Movie Vote Count
  var voteCount: String { get }
  
  /// The Movie Synopsis
  var synopsis: String { get }
  
  /// Closure for handling play movie trailer button
  var didTapPlayButton: ((String) -> Void)? { get }
  
  /// The movie url path for displaying movie back drop poster
  var backdropPath: String { get }
  
  /// The movie url path for displaying movie poster
  var posterPath: String { get }
  
  /// Method that calls the API Client to fetch movie details
  func fetchMovieTrailer()
  
  /// Public facing method that calls the didTapPlayButton closure
  func showMovieTrailer()
}
