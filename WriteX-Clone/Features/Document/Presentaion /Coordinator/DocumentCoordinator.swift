//
//  DocumentCoordinator.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import UIKit

class DocumentCoordinator: BaseCoordinatorImplementation {
    
    
    private var parentNavigationController: UINavigationController
    private var documentViewModel: DocumentViewModel!
    
    init(parentNavigatioController: UINavigationController = UINavigationController()) {
        self.parentNavigationController = parentNavigatioController
    }
    
    
    override func startCoordinatorWithNavigationController() -> UINavigationController {
        parentNavigationController.navigationBar.isHidden = false
        
        documentViewModel = DocumentViewModel(coordinator: self)
        let documentVC = DocumentViewController(viewModel: documentViewModel)
        
        documentVC.title = "Document"
        documentVC.tabBarItem.image = UIImage(systemName: "folder")
        
        self.navigationController = UINavigationController(rootViewController: documentVC)
        return self.navigationController
    }
    
    
    func pressentToAddNote(note: Note? ){
        let addNoteCoordinator = AddNoteCoordinator(parentNavigationController: parentNavigationController)
        addNoteCoordinator.startCoordinatorWithNote(note: note, fetchProtocol: documentViewModel)
    }
    
    
    func documentAsHiddenNotes(){
        documentViewModel = DocumentViewModel(coordinator: self, isHidden: true)
        let documentVC = DocumentViewController(viewModel: documentViewModel)
        documentVC.title = "Document"
//        parentNavigationController.navigationBar.isHidden = false
        parentNavigationController.pushViewController(documentVC , animated: true)
    }
    
    func finishCoord(){
        parentNavigationController.navigationBar.isHidden = true
    }
    
}
