//
//  AppCoordinator.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppCooordinator: Coordinator {
    
    // MARK: - Properties
    
    lazy var rootViewController = RootViewController()
    
    private lazy var tabBarController: UITabBarController = {
        // Initialize Tab Bar Controller
        let tabBarController = UITabBarController()
        
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
        
        return tabBarController
    }()
    
    // MARK: - Overrides
    
    override func start() {
        // Set Child View Controller
        rootViewController.childViewController = tabBarController
        
        // Start Child Coordinators
        childCoordinators.forEach { childCoordinators in
            childCoordinators.start()
        }
    }
}
