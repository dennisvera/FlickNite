//
//  MoviesCollectionViewCell.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
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
    addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Public API
  
  func configure(with presentable: MoviesPresentable?) {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    guard let posterPath = presentable?.posterPath else { return }
    let url = URL(string: imageBaseUrl + posterPath)
    let thumbnailSize = CGSize(width: 400, height: 400)
    imageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
  }
}
