//
//  APIClient.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

internal protocol APIClient: AnyObject {
  
  func fetchMovies(pageIndex: Int, completion: @escaping (Result<MovieResponse, APIError>) -> Void)
}
