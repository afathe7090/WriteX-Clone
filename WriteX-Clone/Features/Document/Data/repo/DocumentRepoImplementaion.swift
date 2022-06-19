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
    
    func returnNotesAfterInAllCaseOFFillters(_ notes: Observable<[Note]> ,
                                             search: Observable<String>, isHidden: Bool) -> Observable<[Note]> {
        return Observable.combineLatest(notes, search).map { (notes ,search) ->[Note]  in
            let fakeNotes:[Note] = [Note(title: "", discription: "", date: "")]
            if search.isEmpty { return (fakeNotes + notes.filter({ $0.isHidden == isHidden })) }
            return (notes
                        .filter({$0.title.lowercased().contains(search.lowercased()) && $0.isHidden == isHidden}))
        }
    }
}

