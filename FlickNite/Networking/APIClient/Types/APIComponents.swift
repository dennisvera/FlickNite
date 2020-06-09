//
//  APIComponents.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/9/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

 // MARK: - Types

private enum QueryItem: String {
  
  // MARK: - Cases
  
  case apiKey = "2631ea46e7edd7894cf3eaee7d263667"
  case language = "en-US"
}

enum API {
  
  // MARK: - Cases
  
  case getMovies(pageIndex: Int)
  
  // MARK: - URL Components
  
  var url: URL? {
    var component = URLComponents()
    component.scheme = "https"
    component.host = "api.themoviedb.org"
    component.path = path
    component.queryItems = pageQuery()
    return component.url
  }
  
  // MARK: - URL Query Items
  
  private func pageQuery()-> [URLQueryItem]? {
    switch self {
    case .getMovies(let page):
      return [
        URLQueryItem(name: "api_key", value: QueryItem.apiKey.rawValue),
        URLQueryItem(name: "language", value: QueryItem.language.rawValue),
        URLQueryItem(name: "page", value: page.description)
      ]
    }
  }
}

extension API {
  
  fileprivate var path: String {
    switch self {
    case .getMovies:
      return "/3/movie/now_playing"
    }
  }
}
