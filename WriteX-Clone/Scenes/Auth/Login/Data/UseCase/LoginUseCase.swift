//
//  LoginUseCase.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import RxCocoa
import RxSwift
import Firebase

class LoginUseCase{
    
    let loginRepo: LoginRepo
    
    init(loginRepo: LoginRepo = LoginRepoImplementation()){
        self.loginRepo = loginRepo
    }
    
    func signIn(email: BehaviorRelay<String>, password: BehaviorRelay<String> ,completion: @escaping (AuthDataResult?, Error?) -> Void) {
        loginRepo.signIn(email: email, password: password, completion: completion)
    }
}


