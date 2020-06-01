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
  
  public let id: Int
  public let title: String
  public let overview: String
  public let releaseDate: String
}
