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
    
    
    //MARK: - Proberties
    private var coordinator: DocumentCoordinator?
    
    let notesPublisher: PublishRelay<[Note]> = PublishRelay()
    let searchBarText: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var dataSource = RxCollectionViewSectionedReloadDataSource<SectionDataSources<Note>> { _, _, _, _ in
        fatalError()
    }
    
    let useCase: DocumentUseCase = DocumentUseCase()
    
    
    
    
    //MARK: -  Init
    init(coordinator: DocumentCoordinator = DocumentCoordinator()){
        self.coordinator = coordinator
    }
    
    
    //MARK: - Helper FUnctions
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
    
    
    
    func didSelectItemAtIndexAndNotes( note: Note , indexPath: IndexPath){
        
        if ( indexPath.row == 0         &&       searchBarText.value.isEmpty ){
            
            print("start adding")
            // start to add notes with present from coordinator
        }else{
            // edit notes
            print(note)
        }
    }
    
    
}

