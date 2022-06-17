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
        
        
        // Fetch Data
        loadDataOFNotes()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigatonBar()
    }
    
    
    
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
    
    
    
    
    
    //MARK: - DataSource of collectionView
    fileprivate func configureCollectionViewDataSource(){
        viewModel.dataSource.configureCell = {(dataSource , collectionView, indexPath , note ) -> UICollectionViewCell in
            if (indexPath.row == 0 && self.viewModel.searchBarText.value.isEmpty) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.cellID,
                                                              for: indexPath) as! AddCell
                return cell
                
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.cellID,
                                                              for: indexPath) as! NotesCell
                cell.configureCellData(note: note)
                return cell
            }
        }
    }
    
    
    fileprivate func configureDataSourceDataFromNotes(){
        loadDataOFNotes()
        
        viewModel.returnNotesAfterInAllCaseOFFillters()
            .map({[SectionDataSources(header: "", items: $0)]})
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
    }
    
    //MARK: -  Fetch Data oF Notes
    fileprivate func loadDataOFNotes(){
        viewModel.noteDemoData()
    }
    
}

