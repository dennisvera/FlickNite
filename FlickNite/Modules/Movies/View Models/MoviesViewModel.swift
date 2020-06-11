//
//  MoviesViewModel.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate: class {
  
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
}

final class MoviesViewModel {
  
  // MARK: - Properties
  
  var delegate: MoviesViewModelDelegate?
  
  private let apiClient: FlickNiteAPIClient
  
  private var currentPage = 1
  private var total = 0
  private var isFetchInProgress = false
  
  private var movies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.moviesDidChange?()
      }
    }
  }
  // MARK: - Public Properties
  
  var currentCount: Int {
    return movies.count
  }
  
  var totalCount: Int {
    return total
  }
  
  var moviesDidChange: (() -> Void)?
  var didSelectMovie: ((Movie) -> Void)?
  
  // MARK: - Initialization
  
  init(apiClient: FlickNiteAPIClient) {
    self.apiClient = apiClient
    
    fetchMovies()
  }
  
  // MARK: - Helper Methods
  
  private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
    let startIndex = movies.count - newMovies.count
    let endIndex = startIndex + newMovies.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }
  
  // MARK: - Public API
  
  func fetchMovies() {
    guard !isFetchInProgress else {
      return
    }
    
    isFetchInProgress = true
    
    apiClient.fetchMovies(pageIndex: currentPage) { [weak self] result in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let movies):
        DispatchQueue.main.async {
          strongSelf.currentPage += 1
          strongSelf.isFetchInProgress = false
          
          strongSelf.total = movies.totalResults
          strongSelf.movies.append(contentsOf: movies.results)
          
          if movies.page > 1 {
            let indexPathsToReload = strongSelf.calculateIndexPathsToReload(from: movies.results)
            strongSelf.delegate?.onFetchCompleted(with: indexPathsToReload)
          } else {
            strongSelf.delegate?.onFetchCompleted(with: .none)
          }
        }
      case .failure(let error):
        DispatchQueue.main.async {
          strongSelf.isFetchInProgress = true
          strongSelf.delegate?.onFetchFailed(with: error.localizedDescription)
        }
      }
    }
  }
  
  func movies(at index: Int) -> Movie {
    return movies[index]
  }
  
  func selectMovie(at index: Int) {
    didSelectMovie?(movies[index])
  }
  
  // BUG: - the presentable func crashes the app when called on the cell for row at.
  // This started happening after the prefetching implementation.
  
  //  func presentable(for index: Int) -> MoviesPresentable {
  //    return movies(at: index)
  //  }
}
