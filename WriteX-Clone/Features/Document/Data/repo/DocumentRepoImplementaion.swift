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
    
    
    private var realm: RealmDBManagerProtocol {
        return RealmDBManager()
    }

    
    
    
    func returnNotesAfterInAllCaseOFFillters(_ notes: Observable<[Note]> ,
                                             search: Observable<String>, isHidden: Bool) -> Observable<[Note]> {
        return Observable.combineLatest(notes, search).map { (notes ,search) ->[Note]  in
            let fakeNotes:[Note] = [Note(title: "", discription: "", date: "", isHidden: isHidden)]
            if search.isEmpty { return (fakeNotes + notes.filter({ $0.isHidden == isHidden })) }
            return (notes
                        .filter({$0.title.lowercased().contains(search.lowercased()) && $0.isHidden == isHidden}))
        }
    }
    
    func writeNoteTORealm(_ notes: [Note]){
        
        realm.deletAll()
        notes.forEach { note in
            let noteRelam = RealmNotes()
            noteRelam.title = note.title
            noteRelam.discription = note.discription
            noteRelam.date  = note.date
            noteRelam.isHidden = note.isHidden
            
            print("the Notes OF Realm \(noteRelam)")
            realm.insert(noteRelam)
        }
    }
    
    func readNotesFromRealm()-> [Note]?{
        var notes: [Note] = []
        realm.read(RealmNotes.self) { resultNotes in
            resultNotes.forEach { realmNote in
                let note = Note(title: realmNote.title, discription: realmNote.discription
                                 , date: realmNote.date, isHidden: realmNote.isHidden)
                notes.append(note)
            }
        }
        return notes
    }
    
    
    
    func deleteNoteFromRealm(){
        
    }
}

