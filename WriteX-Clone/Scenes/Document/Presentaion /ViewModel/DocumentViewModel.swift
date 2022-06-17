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
    
    
    let notesPublisher: PublishRelay<[Note]> = PublishRelay()
    let searchBarText: BehaviorRelay<String> = BehaviorRelay(value: "")

    
    
    var dataSource = RxCollectionViewSectionedReloadDataSource<SectionDataSources<Note>> { _, _, _, _ in
        fatalError()
    }
    
    let useCase: DocumentUseCase = DocumentUseCase()
    
    init(coordinator: DocumentCoordinator = DocumentCoordinator()){
        self.coordinator = coordinator
    }
    
    
    
    func noteDemoData(){
        let notes: [Note] = [.init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "ahme ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "asfd ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false)
        ]
        self.notesPublisher.accept(notes)

    }
        
    func returnNotesAfterInAllCaseOFFillters() -> Observable<[Note]>{
        return useCase.returnNotesAfterInAllCaseOFFillters(notesPublisher , search: searchBarText)
    }
}

