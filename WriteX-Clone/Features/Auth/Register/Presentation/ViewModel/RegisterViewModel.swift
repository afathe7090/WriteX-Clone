//
//  RegisterViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import ProgressHUD

class RegisterViewModel{
    
    private var coordinator: RegisterCoordinator?
    private let bag = DisposeBag()
    private let useCase: RegisterUseCase
    
    let emailBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    let passwordBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    let re_passwordBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    init(coordinator: RegisterCoordinator ,useCase: RegisterUseCase = RegisterUseCase()){
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    
    func signUp(){
        useCase.signUp(email: emailBehavior, password: passwordBehavior) { authResult, error in
            if let error = error  {
                // Progress with Error Resone
                ProgressHUD.showError(error.localizedDescription)
            }else{
                // Progress Succes and show validation
                ProgressHUD.showSuccess("Check your Email to Verification ...")
            }
            
            if let authResult = authResult {
                authResult.user.sendEmailVerification(completion: nil)
            }
        }
    }
    
    func backTopLoginView(){
        coordinator?.popToLoginView()
    }
    
}
