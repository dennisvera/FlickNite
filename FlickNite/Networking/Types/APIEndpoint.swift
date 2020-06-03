//
//  APIEndpoint.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

internal enum APIEndpoint: String {
  
  // MARK: - Cases
  
  case now_playing
  
  // MARK: - Properties
  
  var path: String {
    return rawValue
  }
}
