//
//  LoginViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import ProgressHUD

final class LoginViewModel{
    
    let emailBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    let passwordBehavior: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let loginUseCase: LoginUseCase

    private var coordinator: LoginCoordinator?
    
    init(coordinator: LoginCoordinator? ,loginUseCase: LoginUseCase = LoginUseCase()){
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }

    
    
    func signIn(){
        loginUseCase.signIn(email: emailBehavior, password: passwordBehavior) { authResult , error in
            
            if error != nil {
                // error what to do show progress with error Resone
            }else {
                // go to home and update local database
                self.coordinator?.startToHomeTabBar()
            }
            
            if authResult != nil {
                // success and save uid of user
                
            }
        }
        
        
    }
    
    func pushRegisterView(){
        coordinator?.startRegisterCoordinator()
    }
    
   
}
