//
//  Video.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/24/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct VideoResponse: Decodable {
  
  // MARK: - Properties
  let id: Int
  let results: [Video]
}

struct Video: Decodable {
  
  // MARK: - Properties
  
  let key: String?
}
