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
        
        setupCollectionView()
    }
    
    // MARK: - Helper Methods
    
    private func setupCollectionView() {
        // Register Collection View Cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
    }
}

// MARK: - CollectionView Data Source

extension NowPlayingCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }
        
        cell.backgroundColor = .red
        
        return cell
    }
}
