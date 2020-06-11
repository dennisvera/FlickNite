//
//  MovieDetailViewController.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/10/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
  
  // MARK: - Properties
  
  var movie: Movie?
  
  private let moviePosterImageView: UIImageView = {
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
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = movie?.title
    view.backgroundColor = .white
    setupViews()
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    view.addSubview(moviePosterImageView)
    moviePosterImageView.snp.makeConstraints { make in
      make.centerY.centerX.equalToSuperview()
      make.height.width.equalTo(400)
    }
    
    // Configure Image View
    let imageBaseUrl = "https://image.tmdb.org/t/p/w300/"
    guard let posterPath = movie?.posterPath else { return }
    moviePosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
  }
}
