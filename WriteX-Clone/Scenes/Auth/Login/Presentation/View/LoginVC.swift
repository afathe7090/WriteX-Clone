//
//  LoginVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/06/2022.
//

import UIKit
import RxSwift
import RxCocoa


class LoginVC: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var emailTextField: UITextField! { didSet { emailTextField.setCornerRadius(4) }}
    @IBOutlet weak var passwordTextField: UITextField! { didSet { passwordTextField.setCornerRadius(4) }}
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButtonPressed: UIButton! { didSet { loginButtonPressed.setCornerRadius(7) }}
    @IBOutlet weak var forgetPasswordButtn: UIButton!
    
    private let viewModel: LoginViewModel!
    private let bag = DisposeBag()
    
    
    //MARK: - Init
    init(viewModel: LoginViewModel){
        self.viewModel = viewModel
        super.init(nibName: "LoginVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRegisterButtonAttr()
        configureBindingFromViewModelToTextFields()
        configureTapLoginButton()
        configureTapRegisterButton()
    }


    
    //MARK: - Helper Functions
    fileprivate func configureRegisterButtonAttr(){
        registerButton.addMutableString(txt1: "Don't have an account? "
                                        ,txt2: " Register now")
    }
    
    
    // bind with textField
    // Check Validation of textFields Values
    // register view Setup
    // login with firebase
    
    fileprivate func configureBindingFromViewModelToTextFields(){
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailBehavior).disposed(by: bag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordBehavior).disposed(by: bag)
    }
    
    
    fileprivate func configureTapLoginButton(){
        loginButtonPressed.rx.tap.subscribe(onNext:  {[weak self] _ in
            guard let self = self else { return }
            self.viewModel.signIn()
        }).disposed(by: bag)
    }
    
    fileprivate func configureTapRegisterButton(){
        registerButton.rx.tap.subscribe(onNext:  {[weak self] _ in
            guard let self = self else { return }
            self.viewModel.pushRegisterView()
        }).disposed(by: bag)
    }
}
