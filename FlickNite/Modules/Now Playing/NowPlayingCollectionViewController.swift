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
    
    title = "Now Palying"
    setupCollectionView()
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(NowPlayingCollectionViewCell.self,
                            forCellWithReuseIdentifier: NowPlayingCollectionViewCell.reuseIdentifier)
    collectionView.backgroundColor = .white
  }
}

// MARK: UICollectionViewDataSource

extension NowPlayingCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.numberOfMovies ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Fetch Movies
    guard let movies = viewModel?.movies(at: indexPath.item) else { fatalError("No Movies Available") }
    
    // Dequeue Movie Collection View Cell
    let cell: NowPlayingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    
    // Configure Cell
    cell.titleLabel.text = movies.title
    
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let lineSpacing: CGFloat = 20
    
    return lineSpacing
  }
}
