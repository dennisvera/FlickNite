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
    imageView.contentMode = .scaleAspectFit
    return imageView
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
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    view.addSubview(moviePosterImageView)
    moviePosterImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    // Configure Image View
    let imageBaseUrl = Strings.imageBaseUrl
    guard let posterPath = viewModel?.posterPath else { return }
    moviePosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
  }
}
