//
//  UICollectionViewCell+Helpers.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
  
  // MARK: - Properties
  
  static var nibName: String {
    return String(describing: self)
  }
}
