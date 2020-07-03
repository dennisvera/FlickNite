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
  
  private let scrollview: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  private let detailContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.FlickNite.mediumGray
    return view
  }()
  
  private let detailPosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = Layout.DetailPosterImageView.cornerRadius
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = Layout.TitleLabel.numberOfLines
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
    imageView.widthAnchor.constraint(equalToConstant: Layout.ImageView.width).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: Layout.ImageView.width).isActive = true
    return imageView
  }()
  
  private let voteScoreImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "likes_icon")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.widthAnchor.constraint(equalToConstant: Layout.ImageView.width).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: Layout.ImageView.width).isActive = true
    return imageView
  }()
  
  private let synopsisLabel: UILabel! = {
    let label = UILabel()
    return label
  }()
  
  private let synopsisTextView: UITextView = {
    let textView = UITextView()
    textView.clipsToBounds = true
    textView.isScrollEnabled = false
    textView.backgroundColor = UIColor.FlickNite.darkGray
    return textView
  }()
  
  var viewModel: MovieDetailViewModel?
  private let imageBaseUrl = Strings.imageBaseUrl
  private let synopsis = "Synopsis"
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupPosterView()
    setupDetailContainerView()
    setupSynopsisView()
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
      make.trailing.leading.width.top.equalToSuperview()
      make.height.equalTo(view.snp.height).multipliedBy(Layout.BackgroundPosterView.multipliedHeight)
    }
    
    if viewModel?.backdropPath != "" {
      guard let backdropPath = viewModel?.backdropPath else { return }
      backgroundPosterImageView.sd_setImage(with: URL(string: imageBaseUrl + backdropPath))
    } else {
      guard let posterPath = viewModel?.posterPath else { return }
      backgroundPosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
    }
    
    // Configure Play Button
    backgroundPosterImageView.addSubview(playButton)
    playButton.snp.makeConstraints { make in
      make.centerX.equalTo(backgroundPosterImageView)
      make.width.height.equalTo(Layout.PlayButton.width)
      make.centerY.equalTo(backgroundPosterImageView).offset(Layout.PlayButton.centerY)
    }
    
    playButton.addTarget(self, action: #selector(handlePlayButton), for: .touchUpInside)
  }
  
  private func setupDetailContainerView() {
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    view.addSubview(scrollview)
    scrollview.snp.makeConstraints { make in
      make.bottom.centerX.width.equalToSuperview()
      make.top.equalTo(backgroundPosterImageView.snp.bottom)
    }
    
    // Configure Detail Container View
    scrollview.addSubview(detailContainerView)
    detailContainerView.snp.makeConstraints { make in
      make.width.top.equalToSuperview()
      make.height.equalTo(view.snp.height).multipliedBy(Layout.DetailContainerView.multipliedHeight)
    }

    // Configure Detail Poster Image
    detailContainerView.addSubview(detailPosterImageView)
    detailPosterImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.width.equalTo(Layout.DetailPosterImageView.width)
      make.leading.equalToSuperview().offset(Layout.DetailPosterImageView.leading)
      make.height.equalTo(detailContainerView.snp.height).multipliedBy(Layout.DetailPosterImageView.multipliedHeight)
    }

    guard let posterPath = viewModel?.posterPath else { return }
    detailPosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))

    // Configure Title
    detailContainerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(detailPosterImageView.snp.top).offset(Layout.TitleLabel.topOffset)
      make.leading.equalTo(detailPosterImageView.snp.trailing).offset(Layout.TitleLabel.leading)
    }

    titleLabel.attributedText = viewModel?.title.toTitle(color: UIColor.FlickNite.white,
                                                          textAlignment: .left)

    // Configure Heart Icon Image
    detailContainerView.addSubview(heartIconImageView)
    heartIconImageView.snp.makeConstraints { make in
      make.height.width.equalTo(Layout.HeartIconImageView.height)
      make.leading.equalTo(titleLabel.snp.trailing).offset(Layout.HeartIconImageView.leadingOffset)
      make.top.equalTo(detailPosterImageView.snp.topMargin).offset(Layout.HeartIconImageView.topOffset)
      make.trailing.equalTo(detailContainerView.snp.trailing).offset(Layout.HeartIconImageView.trailingOfffset)
    }

    // Configure Release Info Stack View
    let realeaseInfoStackView = UIStackView(arrangedSubviews: [releaseDateLabel, ratedLabel, runTimeLabel])
    realeaseInfoStackView.axis = .horizontal
    realeaseInfoStackView.distribution = .fillProportionally
    realeaseInfoStackView.spacing = Layout.DetailStackView.spacing

    detailContainerView.addSubview(realeaseInfoStackView)
    realeaseInfoStackView.snp.makeConstraints { make in
      make.leading.equalTo(titleLabel.snp.leading)
      make.top.equalTo(titleLabel.snp.bottom).offset(Layout.DetailStackView.spacing)
      make.trailing.equalTo(detailContainerView.snp.trailing)
        .offset(Layout.DetailStackView.trailingOffset)
        .priority(Layout.DetailStackView.trailingPriority)
    }

    releaseDateLabel.attributedText = viewModel?.releaseDate.toSubtitle(color: UIColor.FlickNite.lightGray,
                                                                        textAlignment: .left)

    ratedLabel.attributedText = "PG".toSubtitle(color: UIColor.FlickNite.lightGray, textAlignment: .left)
    runTimeLabel.attributedText = "133".toSubtitle(color: UIColor.FlickNite.lightGray, textAlignment: .left)

    // Configure Popularity Stack View
    let popularityStackView = UIStackView(arrangedSubviews: [popularityScoreImageView, popularityScoreLabel])
    popularityStackView.axis = .horizontal
    popularityStackView.spacing = Layout.DetailStackView.spacingSix

    popularityScoreLabel.attributedText = viewModel?.popularityScore.toDetail(color: UIColor.FlickNite.lightGray,
                                                                              textAlignment: .left)

    // Configure Vote Score Stack View
    let voteScoreStackView = UIStackView(arrangedSubviews: [voteScoreImageView, voteScoreLabel])
    voteScoreStackView.axis = .horizontal
    voteScoreStackView.spacing = Layout.DetailStackView.spacingSix

    voteScoreLabel.attributedText = viewModel?.voteCount.toDetail(color: UIColor.FlickNite.lightGray,
                                                                  textAlignment: .left)

    // Configure Score Stack View
    let scoreStackView = UIStackView(arrangedSubviews: [popularityStackView, voteScoreStackView])
    scoreStackView.spacing = Layout.DetailStackView.spacing
    scoreStackView.axis = .horizontal
    scoreStackView.distribution = .fillProportionally

    detailContainerView.addSubview(scoreStackView)
    scoreStackView.snp.makeConstraints { make in
      make.leading.equalTo(realeaseInfoStackView.snp.leading)
      make.top.equalTo(realeaseInfoStackView.snp.bottom).offset(Layout.DetailStackView.topOffset)
      make.trailing.equalTo(detailContainerView.snp.trailing)
        .offset(Layout.DetailStackView.trailingOffset)
        .priority(Layout.DetailStackView.trailingPriority)
    }
  }
  
  private func setupSynopsisView() {
    // Configure Synopsis Stack View
    let synopsisStackView = UIStackView(arrangedSubviews: [synopsisLabel, synopsisTextView])
    synopsisStackView.axis = .vertical
    synopsisStackView.alignment = .fill
    synopsisStackView.distribution = .equalCentering
    synopsisStackView.spacing = Layout.SynopsisStackView.spacing

    scrollview.addSubview(synopsisStackView)
    synopsisStackView.snp.makeConstraints { make in
      make.width.equalToSuperview().offset(Layout.SynopsisStackView.widthOffset)
      make.bottom.equalToSuperview().offset(Layout.SynopsisStackView.bottomOffset)
      make.leading.equalToSuperview().offset(Layout.SynopsisStackView.leadingOffset)
      make.trailing.equalToSuperview().offset(Layout.SynopsisStackView.trailingOffset)
      make.top.equalTo(detailContainerView.snp.bottom).offset(Layout.SynopsisStackView.topOffset)
    }

    synopsisLabel.attributedText = synopsis.toSubtitleBold(color: UIColor.FlickNite.white,
                                                           textAlignment: .left)

    synopsisTextView.attributedText = viewModel?.synopsis.toSubtitle(color: UIColor.FlickNite.lightGray,
                                                                     textAlignment: .left)
  }
  
  // MARK: - Actions
  
  @IBAction func handlePlayButton(button: UIButton) {
    playButton.tintColor = UIColor.FlickNite.white
    
    // Notify View Model
    viewModel?.showMovieTrailer()
  }
}

private extension MovieDetailViewController {
  
  // MARK: - Types
  
  enum Layout {
    
    enum ImageView {
      static let width: CGFloat = 24
    }
    
    enum BackgroundPosterView {
      static let multipliedHeight = 0.32
    }
    
    enum PlayButton {
      static let width = 60
      static let centerY = 10
    }
    
    enum DetailContainerView {
      static let multipliedHeight = 0.2
    }
    
    enum DetailPosterImageView {
      static let width = 90
      static let leading = 16
      static let multipliedHeight = 0.82
      static let cornerRadius: CGFloat = 8
    }
    
    enum TitleLabel {
      static let leading = 16
      static let topOffset = 6
      static let numberOfLines = 2
    }
    
    enum HeartIconImageView {
      static let height = 30
      static let topOffset = 2
      static let leadingOffset = 10
      static let trailingOfffset = -20
    }
    
    enum DetailStackView {
      static let topOffset = 14
      static let trailingOffset = 20
      static let spacing: CGFloat = 18
      static let trailingPriority = 750
      static let spacingSix: CGFloat = 6
    }
    
    enum SynopsisStackView {
      static let topOffset = 20
      static let widthOffset = -32
      static let bottomOffset = -40
      static let leadingOffset = 16
      static let trailingOffset = -16
      static let spacing: CGFloat = 10

    }
  }
}
