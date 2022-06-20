//
//  Notes.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import Foundation
import RealmSwift


class RealmNotes: Object{
    @objc dynamic  var title        : String = ""
    @objc dynamic var  discription : String = ""
    @objc dynamic var date        : String = ""
    @objc dynamic var isHidden    : Bool = false
    
    
    func setNotes(note: Note){
        self.title = note.title
        self.discription = note.discription
        self.date = note.date
        self.isHidden = note.isHidden
    }
    
    
}

struct Note: Codable, Equatable, Hashable{
    //    var id          = UUID()
    let title       : String
    let discription : String
    let date        : String
    var isHidden    : Bool
    
    
    init(title: String,discription: String, date : String, isHidden: Bool = false){
        self.title = title
        self.discription = discription
        self.date = date
        self.isHidden = isHidden
    }
    
    init(realmNote: RealmNotes){
        self.title = realmNote.title
        self.discription = realmNote.discription
        self.date = realmNote.date
        self.isHidden = realmNote.isHidden
    }
    
}
