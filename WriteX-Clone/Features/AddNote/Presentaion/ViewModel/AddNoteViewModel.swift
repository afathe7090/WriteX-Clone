//
//  AddNoteViewModel.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 18/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class AddNoteViewModel {
    
    
    private var coordinator: AddNoteCoordinator?
    let noteBehavior: BehaviorRelay<Note?> = BehaviorRelay(value: nil)
    
    let titleTextObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let discribtionTextObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var delegate: FetchNoteProtocol?
    
    
    init(coordinator: AddNoteCoordinator, note: Note? = nil , delegate: FetchNoteProtocol?){
        self.coordinator = coordinator
        self.noteBehavior.accept(note)
        self.delegate = delegate
    }
    
    
    
    func startSavingNote(){
        let note = Note(title: titleTextObservable.value,
                        discription: discribtionTextObservable.value, date: getCurrentData(), isHidden: true)
        
        if noteBehavior.value != nil {
            // update notes
            delegate?.updateNote(note: note)
        }else{
            delegate?.fetchNewNote(note: note)
        }
        
        didFinishAddinView()
    }
    
    
    
    func didFinishAddinView(){
        coordinator?.didFinishView()
    }
    
    
}
