//
//  NowPlayingCollectionViewCell.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class NowPlayingCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    return label
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
      make.height.equalTo(280)
    }
    
    let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Public API
  
  func configure(with presentable: NowPlayingPresentable) {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w200/"
    imageView.sd_setImage(with: URL(string: imageBaseUrl + presentable.posterPath.absoluteString))
    titleLabel.attributedText = presentable.title.toTtitle(color: UIColor.FlickNite.red)
  }
}
