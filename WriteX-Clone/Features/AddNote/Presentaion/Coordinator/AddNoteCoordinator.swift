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
    
    
    func startCoordinatorWithNote(note: Note?, fetchProtocol: FetchNoteProtocol){
        let viewModel = AddNoteViewModel(coordinator: self,note: note, delegate: fetchProtocol)
        let addNoteVC = AddNotesVC(viewModel: viewModel)
        let navigationOfAddNoteVC = UINavigationController(rootViewController: addNoteVC)
        parentNavigationController.present(navigationOfAddNoteVC, animated: true, completion: nil)
    }
    
    
    func didFinishView(){
        didChildCoordinator(self, completion: { _ in })
        parentNavigationController.dismiss(animated: true, completion: nil)
    }
    
}
