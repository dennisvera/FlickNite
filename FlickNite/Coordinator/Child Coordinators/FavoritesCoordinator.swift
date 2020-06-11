//
//  FavoritesCoordinator.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class FavoritesCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var rootViewController: UIViewController {
    return moviesViewController
  }
  
  private lazy var moviesViewController = createNavigationController(viewController: FavoritesViewController(),
                                                                     title: "Favorites",
                                                                     imageName: "")
  
  // MARK: - Helper Methods
  
  private func createNavigationController(viewController: UIViewController,
                                          title: String,
                                          imageName: String) -> UIViewController {
    viewController.navigationItem.title = title
    
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem.title = title
    navigationController.tabBarItem.image = UIImage(named: imageName)
    navigationController.navigationBar.prefersLargeTitles = true
    
    return navigationController
  }
}
