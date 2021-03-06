//
//  MoviesCollectionViewController.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let moviesTitle = Strings.moviesTitle

  var viewModel: MoviesViewModel?
  
  // MARK: - Initialization
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewModel()
    setupCollectionView()
    setupTabAndNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Set Navigation Bar Title
    navigationItem.title = moviesTitle
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    // Remove Navigation Bar Back Button Title
    self.navigationItem.title = ""
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    // Configure Collection View
    collectionView.prefetchDataSource = self
    collectionView.isPrefetchingEnabled = true
    collectionView.backgroundColor = UIColor.FlickNite.mediumGray

    // Register Collection View Cell
    collectionView.register(MoviesCollectionViewCell.self,
                            forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier)
  }
  
  private func setupTabAndNavigationBar() {
    // Set Tab Bar Title
    title = moviesTitle
    
    // Configure Tab Bar Controller
    tabBarController?.tabBar.tintColor = UIColor.FlickNite.white
    tabBarController?.tabBar.barTintColor = UIColor.FlickNite.darkGray
    
    // Configure Navigation Bar
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = UIColor.FlickNite.darkGray
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.FlickNite.white]
  }
  
  private func setupViewModel() {
    viewModel?.delegate = self
    
    // Install Handler
    viewModel?.moviesDidChange = { [weak self] in
      // Update Collection View
      guard let strongSelf = self else { return }
      strongSelf.collectionView.reloadData()
    }
  }
}

// MARK: UICollectionViewDataSource

extension MoviesCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Layout.numberOfSections
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.totalCount ?? Layout.zero
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // BUG: - the presentable func crashes the app when called on the cell for row at.
    // This started happening after the prefetching implementation.
    // Fetch Presentable
    //    guard let presentable = viewModel?.presentable(for: indexPath.item) else { fatalError("No Movies Available.") }
    
    // Dequeue Movie Collection View Cell
    let cell: MoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    
    if isLoadingCell(for: indexPath) {
      cell.configure(with: .none)
    } else {
      // Configure Cell
      cell.configure(with: viewModel?.movies(at: indexPath.item))
    }
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Notify View Model
    viewModel?.selectMovie(at: indexPath.item)
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let totalSpacing = (Layout.numberOfItemsPerRow * Layout.minimumSpacing) + ((Layout.numberOfItemsPerRow - 1) * Layout.minimumSpacing)
    
    if let collection = self.collectionView {
      let width = (collection.bounds.width - totalSpacing) / Layout.numberOfItemsPerRow
      return CGSize(width: width, height: Layout.sizeForItemAtHeight)
    } else {
      return CGSize(width: Layout.zero, height: Layout.zero)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Layout.minimumSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Layout.minimumSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return .init(top: Layout.insetForSectionAt,
                 left: Layout.insetForSectionAt,
                 bottom: Layout.insetForSectionAt,
                 right: Layout.insetForSectionAt)
  }
}

extension MoviesCollectionViewController: MoviesViewModelDelegate {
  
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    guard let newIndexPathsToReload = newIndexPathsToReload else {
      collectionView.reloadData()
      return
    }
    
    let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
  func onFetchFailed(with reason: String) {
    // TO DO: Implement Alert Toast
  }
}

extension MoviesCollectionViewController: UICollectionViewDataSourcePrefetching {
  
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel?.fetchMovies()
    }
  }
}

private extension MoviesCollectionViewController {
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel?.currentCount ?? Layout.zero
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}

private extension MoviesCollectionViewController {
  
  // MARK: - Types
  
  enum Layout {
    
    static let zero = 0
    static let numberOfSections = 1
    static let minimumSpacing: CGFloat = 10.0
    static let insetForSectionAt: CGFloat = 10
    static let numberOfItemsPerRow: CGFloat = 2
    static let sizeForItemAtHeight: CGFloat = 260
  }
}
