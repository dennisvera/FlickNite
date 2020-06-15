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
    
    setupViews()
    setupNavigationBar()
  }
  
  // MARK: - Helper Methods
  
  private func setupNavigationBar() {
    // Set Title
    title = movie?.title
    
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = .white
  }
  
  private func setupViews() {
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    view.addSubview(moviePosterImageView)
    moviePosterImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    // Configure Image View
    let imageBaseUrl = "https://image.tmdb.org/t/p/w300/"
    guard let posterPath = movie?.posterPath else { return }
    moviePosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
  }
}
