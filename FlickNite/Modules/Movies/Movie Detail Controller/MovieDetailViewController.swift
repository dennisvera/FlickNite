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
  
  private let moviePosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let playButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "play_button_icon"), for: .normal)
    button.tintColor = UIColor.FlickNite.white
    return button
  }()
  
  var viewModel: MovieDetailViewModel?
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Make the navigation bar background clear
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    // Remove Navigation Bar Back Button Title
    self.navigationItem.title = ""
    
    navigationController?.navigationBar.isTranslucent = false
  }
  
  // MARK: - Helper Methods
  
  private func setupNavigationBar() {
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = .white
  }
  
  private func setupViews() {
    view.backgroundColor = UIColor.FlickNite.mediumGray
    
    view.addSubview(moviePosterImageView)
    moviePosterImageView.snp.makeConstraints { make in
      make.trailing.leading.width.equalToSuperview()
      make.height.equalTo(view.snp.height).multipliedBy(0.35)
    }
    
    view.addSubview(playButton)
    playButton.snp.makeConstraints { make in
      make.centerX.equalTo(moviePosterImageView)
      make.centerY.equalTo(moviePosterImageView).offset(10)
      make.width.height.equalTo(60)
    }
    
    // Configure Image View
    let imageBaseUrl = Strings.imageBaseUrl
    guard let posterPath = viewModel?.backdropPath else { return }
    moviePosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
  }
}
