//
//  AddNoteVC.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 18/06/2022.
//

import UIKit
import RxCocoa
import RxSwift

class AddNotesVC: UIViewController {
    
    let viewModel: AddNoteViewModel!
    
    @IBOutlet weak var titleTextField: UITextField! { didSet { titleTextField.layer.cornerRadius = 5}}
    @IBOutlet weak var discriptionTextView: UITextView!{ didSet { discriptionTextView.layer.cornerRadius = 10}}
    @IBOutlet weak var heightOfTextView: NSLayoutConstraint!
    
    
    private let saveButtonItem   = UIBarButtonItem(title: "Save", style: .done, target: nil, action: nil)
    private let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: nil, action: nil)
    
    private let bag = DisposeBag()
    
    init(viewModel: AddNoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AddNotesVC", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToSetupUI()
        configureNavigationBar()
        configureTextView()
        
        saveBarButtonItemEnabledByValidationText()
        bindingToTextUI()
        addingNoteAction()
        cancelAddingNote()
    }

    
    fileprivate func configureNavigationBar(){
        navigationItem.rightBarButtonItem = saveButtonItem
        navigationItem.leftBarButtonItem  = cancelButtonItem
    }
    
    
    fileprivate func bindingToTextUI(){
        titleTextField.rx.text.orEmpty.bind(to: viewModel.titleTextObservable).disposed(by: bag)
        discriptionTextView.rx.text.orEmpty.bind(to: viewModel.discribtionTextObservable).disposed(by: bag)
    }
    
    fileprivate func bindToSetupUI(){
        viewModel.noteBehavior.asObservable().subscribe(onNext: {[weak self] note in
            guard let self = self else { return }
            self.title = (note == nil) ? "Add Note":"Edit Note"
            self.titleTextField.text = note?.title
        }).disposed(by: bag)
    }
    
    
    fileprivate func saveBarButtonItemEnabledByValidationText(){
        let textFieldValidationObservable = titleTextField.rx.text.map({!($0?.isEmpty)!})
        let textViewValidationObservable = discriptionTextView.rx.text.map({!($0?.isEmpty)! && $0 != "Enter Discription"})
        Observable.combineLatest(textFieldValidationObservable, textViewValidationObservable)
            .map({$0 && $1}).bind(to: saveButtonItem.rx.isEnabled).disposed(by: bag)
    }
    
    
    fileprivate func cancelAddingNote(){
        cancelButtonItem.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.viewModel.didFinishAddinView()
        }).disposed(by: bag)
    }
    
    fileprivate func addingNoteAction(){
        saveButtonItem.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            // save return notes to home and present it
            self.viewModel.startSavingNote()
        }).disposed(by: bag)
    }
}


