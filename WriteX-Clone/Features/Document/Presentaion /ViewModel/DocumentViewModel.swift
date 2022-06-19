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

protocol FetchNoteProtocol{
    func fetchNewNote(note: Note)
    func updateNote(note: Note)
}


class DocumentViewModel {
    
    
    //MARK: - Proberties
    private var coordinator: DocumentCoordinator?
    
    private let useCase: DocumentUseCase        = DocumentUseCase()
    
    var notesPublisher: PublishRelay<[Note]>    = PublishRelay()
    let collectedNotes: BehaviorRelay<[Note]>   = BehaviorRelay(value: [])
    
    let searchBarText: BehaviorRelay<String>    = BehaviorRelay(value: "")
    let selectedNote: BehaviorRelay<Note?>      = BehaviorRelay(value: nil)
    let isHidden: BehaviorRelay<Bool>           = BehaviorRelay(value: false)
    
    
    
    private let bag = DisposeBag()
    
    
    //MARK: - Data source
    var dataSource = RxCollectionViewSectionedReloadDataSource<SectionDataSources<Note>> { _, _, _, _ in fatalError()}
    
    
    //MARK: -  Init
    init(coordinator: DocumentCoordinator = DocumentCoordinator(),
         isHidden: Bool = false){
        self.coordinator = coordinator
        self.isHidden.accept(isHidden)
    }
    
    
    //MARK: - Helper FUnctions
    func noteDemoData(){
        
        let notes: [Note] = [.init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "ahme ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "asfd ", discription: "Nre kjl ", date: "",isHidden: false),
                             .init(title: "Welcome ", discription: "Nre kjl ", date: "",isHidden: false)
        ]
        
    
        self.collectedNotes.accept(notes)

    }
    
    
    func returnNotesAfterInAllCaseOFFillters() -> Observable<[Note]>{
        return useCase.returnNotesAfterInAllCaseOFFillters(notesPublisher.asObservable()
                                                           , search: searchBarText.asObservable()
                                                           , isHidden: isHidden.value)
    }
    
    
    func updateOFNotesByCollectionObservable(){
        collectedNotes.asObservable().subscribe(onNext: { notes in
            self.notesPublisher.accept(notes)
        }).disposed(by: bag)
    }
    
    
    
    func didSelectItemAtIndexAndNotes( note: Note , indexPath: IndexPath){
        let stateOFSelect = ( indexPath.row == 0  &&  searchBarText.value.isEmpty )
        selectedNote.accept(stateOFSelect ? nil:note)
        coordinator?.pressentToAddNote(note: stateOFSelect ?  nil:note)
        
    }
    
    
}

extension DocumentViewModel: FetchNoteProtocol {
    
    func fetchNewNote(note: Note) {
        collectedNotes.accept([note] + collectedNotes.value)
    }
    
    
    func updateNote(note: Note) {
        if let oldNotes = selectedNote.value {
            var notesEdit:[Note] = collectedNotes.value
            notesEdit.remove(element: oldNotes)
            notesEdit.insert(note, at: 0 )
            collectedNotes.accept(notesEdit)
        }

    }
    
    
    
}
