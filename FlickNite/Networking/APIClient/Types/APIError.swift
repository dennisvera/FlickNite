//
//  APIError.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

internal enum APIError: Error {
  
  // MARK: - Cases
  
  case requestFailed
  case invalidResponse
}
