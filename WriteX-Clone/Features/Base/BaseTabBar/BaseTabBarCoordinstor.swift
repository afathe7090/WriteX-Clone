//
//  BaseTabBarCoordinstor.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import UIKit


class BaseTabBarCoordinstor: BaseCoordinatorImplementation {
    
    private var isRoot = false
    
    init(navigationController : UINavigationController, isRoot: Bool = false) {
        super.init()
        self.isRoot = isRoot
        self.navigationController = navigationController
    }
    
//    
    override func startCoordinator() {
        // start With Coordinate document and settings VC
        
        let newNavigation = UINavigationController()
        
        let tabBar = BaseTabBarController()
        

        let documentCoordinator = DocumentCoordinator(parentNavigatioController: isRoot ? self.navigationController : newNavigation)
        let settingsCoordinator = SettingsCoordinator(parentNavigatioController: isRoot ? self.navigationController : newNavigation)
        
        tabBar.viewControllers = [documentCoordinator.startCoordinatorWithNavigationController() , settingsCoordinator.startCoordinatorWithNavigationController()]
        
        if isRoot {
            self.navigationController.setViewControllers([tabBar], animated: true)
        }else{
            
            newNavigation.setViewControllers([tabBar], animated: true)
            newNavigation.modalPresentationStyle = .fullScreen
            self.navigationController.present(newNavigation, animated: true, completion: nil)
        }
    }
   
    
    
}
