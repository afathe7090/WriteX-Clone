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

class DocumentViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel:  DocumentViewModel!
    
    
    init(viewModel : DocumentViewModel = DocumentViewModel()){
        self.viewModel = viewModel
        super.init(nibName: "DocumentViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) { fatalError()}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
    }
    

}
