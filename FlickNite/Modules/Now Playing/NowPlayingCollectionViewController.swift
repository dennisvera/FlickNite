//
//  NowPlayingCollectionViewController.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  var viewModel: NowPlayingViewModel?
  
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
    
    // Set Title
    title = "Now Palying"
    
    setupViewModel()
    setupCollectionView()
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    // Configure Collection View
    collectionView.prefetchDataSource = self
    collectionView.isPrefetchingEnabled = true
    collectionView.backgroundColor = .white
    
    // Register Collection View Cell
    collectionView.register(NowPlayingCollectionViewCell.self,
                            forCellWithReuseIdentifier: NowPlayingCollectionViewCell.reuseIdentifier)
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

extension NowPlayingCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.totalCount ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // BUG: - the presentable func crashes the app when called on the cell for row at.
    // This started happening after the prefetching implementation.
    // Fetch Presentable
    //    guard let presentable = viewModel?.presentable(for: indexPath.item) else { fatalError("No Movies Available.") }
    
    // Dequeue Movie Collection View Cell
    let cell: NowPlayingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    
    if isLoadingCell(for: indexPath) {
      cell.configure(with: .none)
    } else {
      // Configure Cell
      cell.configure(with: viewModel?.movies(at: indexPath.item))
    }
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension NowPlayingCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: collectionView.bounds.width, height: 340.0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let lineSpacing: CGFloat = 20
    
    return lineSpacing
  }
}

extension NowPlayingCollectionViewController: NowPlayingViewModelDelegate {
  
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

extension NowPlayingCollectionViewController: UICollectionViewDataSourcePrefetching {
  
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel?.fetchMovies()
    }
  }
}

private extension NowPlayingCollectionViewController {
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel?.currentCount ?? 0
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
