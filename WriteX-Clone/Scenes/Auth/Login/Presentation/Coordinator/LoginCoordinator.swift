//
//  LoginCoordinator.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/06/2022.
//

import Foundation
import UIKit


class LoginCoordinator: BaseCoordinatorImplementation {

    
    init(withNav: UINavigationController) {
        super.init()
        self.navigationController = withNav
        setUpNavigationController()
    }
    
    
    override func startCoordinator() {
        let viewModel = LoginViewModel(coordinator: self)
        let lovinViewController = LoginVC(viewModel: viewModel)
        self.navigationController.setViewControllers([lovinViewController], animated: true)
    }
    
    
    func startRegisterCoordinator(){
        // start to register coordinator
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController, parentCoordinator: self)
        childCoordinators.append(registerCoordinator)
        registerCoordinator.startCoordinator()
    }
    
    func startToHomeTabBar(){
        
        let baseCoordinator = BaseTabBarCoordinstor(navigationController: navigationController)
        baseCoordinator.startCoordinator()
        childCoordinators.append(baseCoordinator)
    }
    
    fileprivate func setUpNavigationController(){
        self.navigationController.navigationBar.isHidden = true
    }
    
}
