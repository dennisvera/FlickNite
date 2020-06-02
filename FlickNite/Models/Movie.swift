//
//  Movie.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
  
  // MARK: - Properties
  
  var results: [Movie]
}

struct Movie: Codable {
  
  // MARK: - Properties
  
  let id: Int
  let title: String
  let overview: String
  let releaseDate: String
  let voteAverage: Double
  let posterPath: URL
  let video: Bool
  let voteCount: Int
  let popularity: Double
}
