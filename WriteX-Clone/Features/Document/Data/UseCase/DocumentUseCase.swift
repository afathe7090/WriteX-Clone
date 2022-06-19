//
//  DocumentUseCase.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class DocumentUseCase{
    
    
    var repo: DocumentRepo
    
    
    init(repo: DocumentRepo = DocumentRepoImplementaion()){
        self.repo = repo
    }
    
    func returnNotesAfterInAllCaseOFFillters(_ notes: Observable<[Note]>
                                             , search: Observable<String>,
                                             isHidden: Bool) -> Observable<[Note]>{
        return repo.returnNotesAfterInAllCaseOFFillters(notes, search: search, isHidden: isHidden)
    }
    
}
