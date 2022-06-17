//
//  DocumentViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 08/06/2022.
//

import Foundation
import Firebase
import RxCocoa
import RxSwift
import RxDataSources


class DocumentViewModel {
    
    private var coordinator: DocumentCoordinator?
    
    
    let notes: PublishSubject<[Note]> = PublishSubject()
    var dataSource = RxCollectionViewSectionedReloadDataSource<SectionDataSources<Note>> { _, _, _, _ in
        fatalError()
    }
    
    init(coordinator: DocumentCoordinator = DocumentCoordinator()){
        self.coordinator = coordinator
    }
    
    
    func noteDemoData(){
        let notes: [Note] = [.init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false)
        ]
        self.notes.onNext(notes)
    }
    
}

