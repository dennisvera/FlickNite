//
//  WebView.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/26/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
  
  // MARK: - Properties

  private let webView: WKWebView = {
    let webView = WKWebView(frame: .zero)
    webView.isOpaque = false
    webView.clipsToBounds = true
    webView.backgroundColor = UIColor.FlickNite.darkGray
    return webView
  }()
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .white
    return activityIndicator
  }()
  
  var videoId: String?
  private let youTubeEmbedString = Strings.youTubeEmbedString
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    playMovieTrailer()
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    // Configure View
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    // Set WebView Delegate to self
    webView.navigationDelegate = self
    
    view.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    view.addSubview(activityIndicatorView)
    activityIndicatorView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-100)
    }
  }
  
  private func playMovieTrailer() {
    guard let videoId = videoId else { return }
    guard let videoURL = URL(string: youTubeEmbedString + videoId) else { fatalError() }
    webView.load(URLRequest(url: videoURL))
  }
}

extension WebViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    // Animate Activity Indicator View
    activityIndicatorView.startAnimating()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    activityIndicatorView.stopAnimating()
    activityIndicatorView.isHidden = true
  }
}
