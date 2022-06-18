//
//  AddNoteVC.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 18/06/2022.
//

import UIKit


class AddNoteVC: UIViewController {

    private let viewModel: AddNoteViewModel!
    
    
    init(viewModel: AddNoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AddNoteVC", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
