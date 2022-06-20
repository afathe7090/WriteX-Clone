//
//  DocumentRepoImplementaion.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class DocumentRepoImplementaion: DocumentRepo {
    
    
    private var realm: RealmDBManagerProtocol {
        return RealmDBManager()
    }

    
    //MARK: - setup  notes for datasource and Observe to change all cases
    func returnNotesAfterInAllCaseOFFillters(_ notes: Observable<[Note]> ,
                                             search: Observable<String>, isHidden: Bool) -> Observable<[Note]> {
        return Observable.combineLatest(notes, search).map { (notes ,search) ->[Note]  in
            let fakeNotes:[Note] = [Note(title: "", discription: "", date: "", isHidden: isHidden)]
            if search.isEmpty { return (fakeNotes + notes.filter({ $0.isHidden == isHidden })) }
            return (notes
                        .filter({$0.title.lowercased().contains(search.lowercased()) && $0.isHidden == isHidden}))
        }
    }
    
    
    //MARK: - Write Notes in Database
    func writeNoteTORealm(_ notes: [Note]){
        realm.deletAllByObject(RealmNotes.self)
        notes.forEach { note in
            let realmNote = RealmNotes()
            realmNote.setNotes(note: note)
            print("the Notes OF Realm \(realmNote)")
            realm.insert(realmNote)
        }
    }
    
    //MARK: - Read notes from database
    func readNotesFromRealm()-> [Note]?{
        var notes: [Note] = []
        realm.read(RealmNotes.self) { resultNotes in
            resultNotes.forEach { realmNote in
                let note = Note(realmNote: realmNote)
                notes.append(note)
            }
        }
        return notes
    }
    
    
    
    func deleteNoteFromRealm(){
        
    }
}

