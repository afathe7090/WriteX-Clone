//
//  SettingCoordinator.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import UIKit

class SettingsCoordinator: BaseCoordinatorImplementation {
    
    
    private var parentNavigationController: UINavigationController
    
    
    init(parentNavigatioController: UINavigationController = UINavigationController()) {
        self.parentNavigationController = parentNavigatioController
    }
    
    override func startCoordinatorWithNavigationController() -> UINavigationController {
        
        parentNavigationController.navigationBar.isHidden = true
        let settingViewModel = SettingsViewModel(coordinator: self)
        let settingsVC = SettingsViewController(viewModel: settingViewModel)
        settingsVC.title = "Setting"
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        self.navigationController.setViewControllers([settingsVC], animated: true)
        return self.navigationController
    }
    
    
    func startHiddenCoordinator(){
        let coordinator = DocumentCoordinator(parentNavigatioController: parentNavigationController)
        coordinator.documentAsHiddenNotes()
    }
    
    
}
