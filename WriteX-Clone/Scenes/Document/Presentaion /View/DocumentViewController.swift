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

enum Section {
    case main
}

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
        
        setNavigatonBar()
        configureCollectionViewCells()
        configureCollectionViewDataSource()
        configureDataSourceDataFromNotes()
        
        
        
        loadDataOFNotes()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigatonBar()
    }
    
    
    
    //MARK: - Helper function
    
    
    fileprivate func setNavigatonBar(){
        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func configureCollectionViewCells(){
        
        collectionView.setCollectionViewLayout(.defaultLayout(), animated: true)
        collectionView.register(UINib(nibName: AddCell.cellID, bundle: nil), forCellWithReuseIdentifier: AddCell.cellID)
        collectionView.register(UINib(nibName: NotesCell.cellID, bundle: nil), forCellWithReuseIdentifier: NotesCell.cellID)
    }
    
    
    fileprivate func configureCollectionViewDataSource(){

        viewModel.dataSource.configureCell = {(dataSource , collectionView, indexPath , note ) -> UICollectionViewCell in
            if (indexPath.row == 0) {
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
        
        viewModel.notes.asObserver()
            .map({[SectionDataSources(header: "", items: $0)]})
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource)).disposed(by: bag)
        
    }
    
    
    fileprivate func loadDataOFNotes(){
        viewModel.noteDemoData()
    }
    
    
    
    
    
   
    
    
}
