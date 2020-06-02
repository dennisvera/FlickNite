//
//  UICollectionView+Helpers.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  // MARK: - Helper Methods
  
  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to Dequeue Reusable Collection View Cell")
    }
    
    return cell
  }
}
