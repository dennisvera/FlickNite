//
//  Coordinator.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {
  
  // MARK: - Properties
  
  var didFinish: ((Coordinator) -> Void)?
  
  // MARK: -
  
  var childCoordinators: [Coordinator] = []
  
  // MARK: - Methods
  
  func start() {}
  
  // MARK: -
  
  func navigationController(_ navigationController: UINavigationController,
                            willShow viewController: UIViewController,
                            animated: Bool) {}
  
  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController,
                            animated: Bool) {}
  
  // MARK: -
  
  func pushCoordinator(_ coordinator: Coordinator) {
    // Install Handler
    coordinator.didFinish = { [weak self] (coordinator) in
      guard let strongSelf = self else { return }
      strongSelf.popCoordinator(coordinator)
    }
    
    // Start Coordinator
    coordinator.start()
    
    // Append to Child Coordinators
    childCoordinators.append(coordinator)
  }
  
  func popCoordinator(_ coordinator: Coordinator) {
    // Remove Coordinator From Child Coordinators
    if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
      childCoordinators.remove(at: index)
    }
  }
}
