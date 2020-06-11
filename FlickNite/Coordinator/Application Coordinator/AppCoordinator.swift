//
//  AppCoordinator.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var rootViewController: UIViewController {
    return tabBarController
  }
  
  private let tabBarController = UITabBarController()
  
  // MARK: - Initialization
  
  override init() {
    super.init()
    
    // Initialize Child Coordinators
    let nowPlayingCoordinator = NowPlayingCoordinator()
    let moviesCoordinator = MoviesCoordinator()
    
    // Update View Controllers
    tabBarController.viewControllers = [
      nowPlayingCoordinator.rootViewController,
      moviesCoordinator.rootViewController
    ]
    
    // Append to Child Coordinators
    childCoordinators.append(nowPlayingCoordinator)
    childCoordinators.append(moviesCoordinator)
  }
  
  // MARK: - Overrides
  
  override func start() {
    childCoordinators.forEach { (childCoordinator) in
      // Start Child Coordinator
      childCoordinator.start()
    }
  }
}
