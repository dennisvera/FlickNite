//
//  Movie.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
  
  // MARK: - Properties
  
  var results: [Movie]
}

struct Movie: Decodable {
  
  // MARK: - Properties
  
  let id: Int
  let title: String
  let video: Bool
  let overview: String
  let voteCount: Int
  let posterPath: String?
  let releaseDate: String
  let voteAverage: Double
}
