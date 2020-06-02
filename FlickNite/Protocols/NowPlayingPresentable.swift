//
//  NowPlayingPresentable.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/2/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

protocol NowPlayingPresentable {
  
   // MARK: - Properties
  
  var title: String { get }
  var posterPath: URL { get }
}

extension Movie: NowPlayingPresentable {}
