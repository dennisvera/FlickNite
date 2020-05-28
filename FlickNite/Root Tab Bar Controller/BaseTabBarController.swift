//
//  BaseTabBarController.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewControlers()
    }
    
    //MARK: - Helper Methods
    
    private func createViewControlers() {
        viewControllers = [
            createNavigationController(viewController: NowPlayingCollectionViewController(), title: "Now Playing", imageName: ""),
            createNavigationController(viewController: MoviesViewController(), title: "Movies", imageName: "")
        ]
    }
    
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
