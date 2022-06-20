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
         isHidden: Bool = true){
        self.coordinator = coordinator
        self.isHidden.accept(isHidden)
    }
    
    
    //MARK: - Helper FUnctions
    func noteDemoData(){
        
        if let notes = useCase.readNotesFromRealm() {
            self.collectedNotes.accept(notes)
        }else {
            print("No Data found in Realm ......")
        }

    }
    
    
    func returnNotesAfterInAllCaseOFFillters() -> Observable<[Note]>{
        return useCase.returnNotesAfterInAllCaseOFFillters(notesPublisher.asObservable()
                                                           , search: searchBarText.asObservable()
                                                           , isHidden: isHidden.value)
    }
    
    
    func updateOFNotesByCollectionObservable(){
        collectedNotes.asObservable().subscribe(onNext: {[weak self] notes in
            guard let self = self else { return }
            self.notesPublisher.accept(notes)
            self.useCase.writeNoteTORealm(notes)
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
