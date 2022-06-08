//
//  RegisterRepoImplementation.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import RxSwift
import RxCocoa
import Firebase

class RegisterRepoImplementation: RegisterRepo{
    
    private var firebaseAuth: FirebaseAuthRepo
    
    init(firebaseAuth: FirebaseAuthRepo = FirebaseAuthImplementation()) {
        self.firebaseAuth = firebaseAuth
    }
    
    
    func signUp(email: BehaviorRelay<String>, password: BehaviorRelay<String>, comletion: @escaping (AuthDataResult?, Error?) -> Void) {
        firebaseAuth.signUp(email: email, password: password, completion: comletion)
    }
    
}
