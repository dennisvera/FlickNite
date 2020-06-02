//
//  ReusableView.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

protocol ReusableView {

  // MARK: - Properties

  static var reuseIdentifier: String { get }
}

extension ReusableView {

  // MARK: - Properties

  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionViewCell: ReusableView {}
