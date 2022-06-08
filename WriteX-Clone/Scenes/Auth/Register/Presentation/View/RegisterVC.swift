//
//  RegisterVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterVC: UIViewController {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var backButtonPressed: UIButton! { didSet { backButtonPressed.setCornerRadius(20) }}
    @IBOutlet weak var confirmPasswordTextField: UITextField! { didSet { confirmPasswordTextField.setCornerRadius(4) }}
    @IBOutlet weak var passwordTextField: UITextField!  { didSet { passwordTextField.setCornerRadius(4) }}
    @IBOutlet weak var registerButtonPressed: UIButton!  { didSet { registerButtonPressed.setCornerRadius(7) }}
    @IBOutlet weak var emailTextField: UITextField! { didSet { emailTextField.setCornerRadius(4) }}
    @IBOutlet weak var loginPageButton: UIButton! { didSet { loginPageButton.addMutableString(txt1: "I have an account ", txt2: " Login") }}
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Var
    //----------------------------------------------------------------------------------------------------------------
    private let viewModel: RegisterViewModel!
    private let bag = DisposeBag()
    
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RegisterVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingWithViewModel()
        subscribeToSignUpButton()
        subscribeToLoginAndBackButtonTaps()
    }
    
    
    //MARK: - Helper Functions
    
    
    fileprivate func bindingWithViewModel(){
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailBehavior).disposed(by: bag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordBehavior).disposed(by: bag)
        confirmPasswordTextField.rx.text.orEmpty.bind(to: viewModel.re_passwordBehavior).disposed(by: bag)
    }
    

    
    fileprivate func subscribeToSignUpButton(){
        registerButtonPressed.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.signUp()
        }).disposed(by: bag)
    }
    
    
    fileprivate func subscribeToLoginAndBackButtonTaps(){
        Observable.merge([loginPageButton.rx.tap.asObservable() ,
                          backButtonPressed.rx.tap.asObservable()]).subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.viewModel.backTopLoginView()
        }).disposed(by: bag)
    }
    
}
