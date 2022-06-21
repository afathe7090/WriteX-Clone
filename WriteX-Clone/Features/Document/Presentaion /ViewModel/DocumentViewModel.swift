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
    
    
    //MARK: - Data Use Case
    private let useCase: DocumentUseCase        = DocumentUseCase()
    
    
    
    //MARK: - Relayes Observable
    var notesPublisher: PublishRelay<[Note]>    = PublishRelay()
    let collectedNotes: BehaviorRelay<[Note]>   = BehaviorRelay(value: [])
    
    let searchBarText: BehaviorRelay<String>    = BehaviorRelay(value: "")
    let selectedNote: BehaviorRelay<Note?>      = BehaviorRelay(value: nil)
    let isHidden: BehaviorRelay<Bool>           = BehaviorRelay(value: false)
    
    
    //MARK: - Bag
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
        
        if let notes = useCase.readNotesFromRealm() {
            self.collectedNotes.accept(notes)
        }else {
            print("No Data found in Realm ......")
        }

    }
    
    //MARK: - Filltered Notes datasource
    func returnNotesAfterInAllCaseOFFillters() -> Observable<[Note]>{
        return useCase.returnNotesAfterInAllCaseOFFillters(notesPublisher.asObservable()
                                                           , search: searchBarText.asObservable()
                                                           , isHidden: isHidden.value)
    }
    
    //MARK: - Update Publisher of Notes and Database
    func updateOFNotesByCollectionObservable(){
        collectedNotes.asObservable().subscribe(onNext: {[weak self] notes in
            guard let self = self else { return }
            self.notesPublisher.accept(notes)
            self.useCase.writeNoteTORealm(notes)
        }).disposed(by: bag)
    }
    
    
    //MARK: - didSelect CollectionView
    func didSelectItemAtIndexAndNotes( note: Note , indexPath: IndexPath){
        let stateOFSelect = ( indexPath.row == 0  &&  searchBarText.value.isEmpty )
        selectedNote.accept(stateOFSelect ? nil:note)
        coordinator?.pressentToAddNote(note: stateOFSelect ?  nil:note)
        
    }
    
    
    func didFinish(){
        coordinator?.finishCoord()
    }
    
    
}

//MARK: - Protocol With Setup notes from the add Notes VC
extension DocumentViewModel: FetchNoteProtocol {
    
    // new note
    func fetchNewNote(note: Note) {
        collectedNotes.accept([note] + collectedNotes.value)
    }

    // update note
    func updateNote(note: Note) {
        if let oldNotes = selectedNote.value {
            var notesEdit:[Note] = collectedNotes.value
            notesEdit.remove(element: oldNotes)
            notesEdit.insert(note, at: 0 )
            collectedNotes.accept(notesEdit)
        }

    }
    
    
    
}
