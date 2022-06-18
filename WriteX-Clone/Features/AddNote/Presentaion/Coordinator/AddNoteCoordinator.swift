//
//  AddNoteCoordinator.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 18/06/2022.
//

import Foundation
import UIKit


class AddNoteCoordinator: BaseCoordinatorImplementation {
    
    private var parentNavigationController: UINavigationController = UINavigationController()
    
    init(parentNavigationController: UINavigationController){
        self.parentNavigationController = parentNavigationController
    }
    
    
    override func startCoordinator() {}
    
    
    func startCoordinatorWithNote(note: Note?){
        let viewModel = AddNoteViewModel(coordinator: self
                                         ,note: note)
        let addNoteVC = AddNoteVC(viewModel: viewModel)
        parentNavigationController.present(addNoteVC, animated: true, completion: nil)
    }
    
    
}
