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
  
  let page: Int
  let results: [Movie]
  let totalResults: Int
}

struct Movie: Decodable {
  
  // MARK: - Properties
  
  let id: Int
  let video: Bool
  let title: String
  let voteCount: Int
  let overview: String
  let releaseDate: String
  let voteAverage: Double
  let posterPath: String?
}
