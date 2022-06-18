//
//  RegisterCoordinator.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import UIKit


class RegisterCoordinator: BaseCoordinatorImplementation {
    
    private var parentCoordinator: LoginCoordinator?
    
    init(navigationController: UINavigationController , parentCoordinator: LoginCoordinator? = nil) {
        super.init()
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    override func startCoordinator() {
        let registerViewModel = RegisterViewModel(coordinator: self)
        let registgerViewController = RegisterVC(viewModel: registerViewModel)
        self.navigationController.pushViewController(registgerViewController, animated: true)
    }
    
    
    func popToLoginView(){
        parentCoordinator?.didChildCoordinator(self, completion: { viewCoordinate in
            viewCoordinate.popViewController(animated: true)
        })
    }
    
}
