//
//  RootViewController.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    var childViewController: UIViewController? {
        didSet {
            // Replace Child View Controller
            replace(viewController: oldValue, with: childViewController)
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper Methods
    
    private func replace(viewController from: UIViewController?, with to: UIViewController?) {
        if let viewController = from {
            // Remove Child View From Superview
            viewController.view.removeFromSuperview()
            
            // Notify Child View Controller
            viewController.didMove(toParent: nil)
        }
        
        if let viewController = to {
            // Add Child View Controller
            addChild(viewController)
            
            // Add Child View as Subview
            view.addSubview(viewController.view)
            
            // Configure Child View
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            // Notify Child View Controller
            viewController.didMove(toParent: self)
        }
    }
}
