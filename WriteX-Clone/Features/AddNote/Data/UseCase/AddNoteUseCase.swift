//
//  AddNoteUseCase.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 18/06/2022.
//

import Foundation



class AddNoteUseCase {
    
    private let repo: AddNotesRepo
    
    
    init(repo: AddNotesRepo = AddNotesRepoImplementation()){
        self.repo = repo
    }
    
    
    
    
}
