//
//  RegisterUseCase.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

class RegisterUseCase{
    
    private let registerRepo: RegisterRepo
    
    init(registerRepo: RegisterRepo = RegisterRepoImplementation()){
        self.registerRepo = registerRepo
    }
    
    func signUp(email: BehaviorRelay<String>, password: BehaviorRelay<String>, comletion: @escaping (AuthDataResult?, Error?) -> Void) {
        registerRepo.signUp(email: email, password: password, comletion: comletion)
    }
    
}
