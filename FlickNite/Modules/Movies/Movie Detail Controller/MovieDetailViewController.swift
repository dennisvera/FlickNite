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
  
  private let backgroundPosterImageView: UIImageView = {
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
  
  private let detailContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.FlickNite.mediumGray
    return view
  }()
  
  private let detailPosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    return label
  }()
  
  private let heartIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.image = #imageLiteral(resourceName: "heart_icon").withRenderingMode(.alwaysTemplate)
    imageView.tintColor = UIColor.FlickNite.white
    return imageView
  }()
  
  private let releaseDateLabel: UILabel! = {
    let label = UILabel()
    return label
  }()
  
  private let ratedLabel: UILabel! = {
    let label = UILabel()
    return label
  }()
  
  private let runTimeLabel: UILabel! = {
    let label = UILabel()
    return label
  }()
  
  private let popularityScoreLabel: UILabel! = {
    let label = UILabel()
    return label
  }()
  
  private let voteScoreLabel: UILabel! = {
    let label = UILabel()
    return label
  }()
  
  private let popularityScoreImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "popcorn_icon")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    return imageView
  }()
  
  private let voteScoreImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "likes_icon")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    return imageView
  }()
  
  var viewModel: MovieDetailViewModel?
  private let imageBaseUrl = Strings.imageBaseUrl
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupPosterView()
    setupDetailContainerViews()
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
  
  private func setupPosterView() {
    // Configure Backdrop Image View
    view.addSubview(backgroundPosterImageView)
    backgroundPosterImageView.snp.makeConstraints { make in
      make.trailing.leading.width.equalToSuperview()
      make.height.equalTo(view.snp.height).multipliedBy(0.32)
    }
    
    if viewModel?.backdropPath != "" {
      guard let backdropPath = viewModel?.backdropPath else { return }
      backgroundPosterImageView.sd_setImage(with: URL(string: imageBaseUrl + backdropPath))
    } else {
      guard let posterPath = viewModel?.posterPath else { return }
      backgroundPosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
    }
    
    // Configure Play Button
    view.addSubview(playButton)
    playButton.snp.makeConstraints { make in
      make.centerX.equalTo(backgroundPosterImageView)
      make.centerY.equalTo(backgroundPosterImageView).offset(10)
      make.width.height.equalTo(60)
    }
    
    playButton.addTarget(self, action: #selector(handlePlayButton), for: .touchUpInside)
  }
  
  private func setupDetailContainerViews() {
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    // Configure Detail Container View
    view.addSubview(detailContainerView)
    detailContainerView.snp.makeConstraints { make in
      make.trailing.leading.equalToSuperview()
      make.top.equalTo(backgroundPosterImageView.snp.bottom)
      make.height.equalTo(view.snp.height).multipliedBy(0.2)
    }
    
    // Configure Detail Poster Image
    detailContainerView.addSubview(detailPosterImageView)
    detailPosterImageView.snp.makeConstraints { make in
      make.width.equalTo(90)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(16)
      make.height.equalTo(detailContainerView.snp.height).multipliedBy(0.82)
    }
    
    guard let posterPath = viewModel?.posterPath else { return }
    detailPosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
    
    // Configure Title
    detailContainerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(detailPosterImageView.snp.trailing).offset(16)
      make.top.equalTo(detailPosterImageView.snp.top).offset(6)
    }
    
    titleLabel.attributedText = viewModel?.title.toTtitle(color: UIColor.FlickNite.white,
                                                          textAlignment: .left)
    
    // Configure Heart Icon Image
    detailContainerView.addSubview(heartIconImageView)
    heartIconImageView.snp.makeConstraints { make in
      make.height.width.equalTo(30)
      make.top.equalTo(detailPosterImageView.snp.topMargin).offset(2)
      make.trailing.equalTo(detailContainerView.snp.trailing).offset(-20)
      make.leading.equalTo(titleLabel.snp.trailing).offset(10)
    }
    
    // Configure Release Info Stack View
    let realeaseInfoStackView = UIStackView(arrangedSubviews: [releaseDateLabel, ratedLabel, runTimeLabel])
    realeaseInfoStackView.spacing = 18
    realeaseInfoStackView.axis = .horizontal
    realeaseInfoStackView.distribution = .fillProportionally
    
    detailContainerView.addSubview(realeaseInfoStackView)
    realeaseInfoStackView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(14)
      make.leading.equalTo(titleLabel.snp.leading)
      make.trailing.equalTo(detailContainerView.snp.trailing).offset(20).priority(750)
    }
    
    releaseDateLabel.attributedText = viewModel?.releaseDate.toSubtitle(color: UIColor.FlickNite.lightGray,
                                                                        textAlignment: .left)
    
    ratedLabel.attributedText = "PG".toSubtitle(color: UIColor.FlickNite.lightGray, textAlignment: .left)
    runTimeLabel.attributedText = "133".toSubtitle(color: UIColor.FlickNite.lightGray, textAlignment: .left)
    
    // Configure Popularity Stack View
    let popularityStackView = UIStackView(arrangedSubviews: [popularityScoreImageView, popularityScoreLabel])
    popularityStackView.axis = .horizontal
    popularityStackView.spacing = 6
    
    
    popularityScoreLabel.attributedText = viewModel?.popularityScore.toDetail(color: UIColor.FlickNite.lightGray,
                                                                              textAlignment: .left)
    
    // Configure Vote Score Stack View
    let voteScoreStackView = UIStackView(arrangedSubviews: [voteScoreImageView, voteScoreLabel])
    voteScoreStackView.axis = .horizontal
    voteScoreStackView.spacing = 6
    
    voteScoreLabel.attributedText = viewModel?.voteCount.toDetail(color: UIColor.FlickNite.lightGray, textAlignment: .left)
    
    // Configure Score Stack View
    let scoreStackView = UIStackView(arrangedSubviews: [popularityStackView, voteScoreStackView])
    scoreStackView.spacing = 18
    scoreStackView.axis = .horizontal
    scoreStackView.distribution = .fillProportionally
    
    detailContainerView.addSubview(scoreStackView)
    scoreStackView.snp.makeConstraints { make in
      make.leading.equalTo(realeaseInfoStackView.snp.leading)
      make.top.equalTo(realeaseInfoStackView.snp.bottom).offset(14)
      make.trailing.equalTo(detailContainerView.snp.trailing).offset(20).priority(750)
    }
  }
  
  // MARK: - Actions
  
  @IBAction func handlePlayButton(button: UIButton) {
    playButton.tintColor = UIColor.FlickNite.white

    // Notify View Model
    viewModel?.showMovieTrailer()
  }
}
