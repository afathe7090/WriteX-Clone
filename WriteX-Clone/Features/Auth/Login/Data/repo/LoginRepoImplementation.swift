//
//  LoginRepoImplementation.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
class LoginRepoImplementation: LoginRepo {
    
    private var firebaseAuth: FirebaseAuthRepo
    
    init(firebaseAuth: FirebaseAuthRepo = FirebaseAuthImplementation()) {
        self.firebaseAuth = firebaseAuth
    }
    
    
    func signIn(email: BehaviorRelay<String>, password: BehaviorRelay<String> ,completion: @escaping (AuthDataResult?, Error?) -> Void) {
        // Sign in With firebase
        firebaseAuth.signIn(email: email, password: password, completion: completion)
    }
    
    
    
}
