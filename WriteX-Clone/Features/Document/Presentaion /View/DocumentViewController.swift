//
//  DocumentViewController.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase
import RxDataSources


class DocumentViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    private var viewModel:  DocumentViewModel!
    private let bag = DisposeBag()
    
    //MARK: -  Init
    init(viewModel : DocumentViewModel = DocumentViewModel()){
        self.viewModel = viewModel
        super.init(nibName: "DocumentViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) { fatalError()}
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ui Configuration
        setNavigatonBar()
        setUpSearchController()
        configureLayOutCollectionView()
        configureOfNibFilesTOCollectionView()
        
        
        // Binding
        bindingWithSearchBarText()
        bindingWithSearchBarText()
        
        // DataSource COllection View
        configureDataSourceDataFromNotes()
        configureCollectionViewDataSource()
        didSelectItemByIndexAndNotesForCollectionView()
        
        // Fetch Data
        loadDataOFNotes()
        
    }
    
    deinit{
//        viewModel.didFinish()
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        viewModel.didFinish()
//    }
//
    
    //MARK: - Helper function
    
    //MARK: - UI handeler
    fileprivate func setNavigatonBar(){
        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    fileprivate func setUpSearchController(){
        navigationItem.searchController                       = searchController
        searchController.searchBar.placeholder                = "Search Note"
        searchController.searchBar.autocapitalizationType     = .none
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    
    
    fileprivate func configureLayOutCollectionView(){
        collectionView.setCollectionViewLayout(.defaultLayout(), animated: true)
    }
    
    
    fileprivate func configureOfNibFilesTOCollectionView(){
        let identifierCells: [String] = [AddCell.cellID , NotesCell.cellID]
        collectionView.configureNibWithIdentifier(identifier: identifierCells)
        
    }
    
    
    //MARK: - Binding
    
    
    
    fileprivate func bindingWithSearchBarText(){
        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchBarText).disposed(by: bag)
    }
    
    
    fileprivate func configureDataSourceDataFromNotes(){
        viewModel.returnNotesAfterInAllCaseOFFillters()
            .map({[SectionDataSources(header: "", items: $0)]})
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
    }
    
    
    //MARK: - DataSource of collectionView
    fileprivate func configureCollectionViewDataSource(){
        viewModel.dataSource.configureCell = {[weak self] (dataSource , collectionView, indexPath , note ) -> UICollectionViewCell in
            guard let self = self else { return UICollectionViewCell() }
            
            if (indexPath.row == 0 && self.viewModel.searchBarText.value.isEmpty) {
                return collectionView.configureReusableCell(identifier: AddCell.cellID, indexPath: indexPath) as! AddCell
            }else {
                let cell = collectionView.configureReusableCell(identifier: NotesCell.cellID, indexPath: indexPath) as! NotesCell
                cell.configureCellData(note: note)
                return cell
            }
        }
    }
    
    
    fileprivate func didSelectItemByIndexAndNotesForCollectionView(){
        Observable.zip(collectionView.rx.modelSelected(Note.self), collectionView.rx.itemSelected)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (note, indexPath) in
                guard let self = self else { return }
                self.viewModel.didSelectItemAtIndexAndNotes(note: note, indexPath: indexPath)
        }).disposed(by: bag)
        
    }
    
    
    //MARK: -  Fetch Data oF Notes
    fileprivate func loadDataOFNotes(){
        viewModel.noteDemoData()
        viewModel.updateOFNotesByCollectionObservable()
        
    }
    
}
