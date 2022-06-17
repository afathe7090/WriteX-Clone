//
//  DocumentRepoImplementaion.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

class DocumentRepoImplementaion: DocumentRepo {
    
    func returnNotesAfterInAllCaseOFFillters(_ notes: PublishRelay<[Note]> , search: BehaviorRelay<String>) -> Observable<[Note]> {
        return Observable.combineLatest(notes, search).map { (notes ,search) ->[Note]  in
            if search.isEmpty { return notes }
            return notes.filter({$0.title.lowercased().contains(search.lowercased())})
        }
    }
}

