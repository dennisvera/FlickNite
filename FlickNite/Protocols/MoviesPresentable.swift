//
//  MoviesPresentable.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/2/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

protocol MoviesPresentable {
  
   // MARK: - Properties
  
  var title: String { get }
  var posterPath: String? { get }
}

extension Movie: MoviesPresentable {}
