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
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let titleLabel: UILabel = {
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
    let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
