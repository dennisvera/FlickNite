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
  
  let movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 12
    imageView.contentMode = .scaleAspectFit
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
  
  override func prepareForReuse() {
    movieImageView.image = nil
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    addSubview(movieImageView)
    movieImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Public API
  
  func configure(with presentable: MoviesPresentable?) {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    guard let posterPath = presentable?.posterPath else { return }
    guard let url = URL(string: imageBaseUrl + posterPath) else { return }
    let thumbnailSize = CGSize(width: 300, height: 300)
    movieImageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
  }
}
