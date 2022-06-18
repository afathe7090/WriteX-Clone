//
//  AddNoteViewModel.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 18/06/2022.
//

import Foundation
import RxRelay


class AddNoteViewModel {
    
    
    private var coordinator: AddNoteCoordinator?
    private let noteBehavior: BehaviorRelay<Note?> = BehaviorRelay(value: nil)
    
    init(coordinator: AddNoteCoordinator, note: Note? = nil){
        self.coordinator = coordinator
        self.noteBehavior.accept(note)
    }
    
    
}
