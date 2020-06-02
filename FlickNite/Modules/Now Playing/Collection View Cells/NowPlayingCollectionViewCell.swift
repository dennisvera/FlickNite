//
//  NowPlayingCollectionViewCell.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
  // MARK: - Properties
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    backgroundColor = .systemOrange
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.centerY.centerX.equalToSuperview()
    }
  }
}
