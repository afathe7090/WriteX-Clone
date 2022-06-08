//
//  FirebaseImplementation.swift
//  WriteX
//
//  Created by Ahmed Fathy on 08/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase


protocol FirebaseAuthRepo {
    func signIn(email: BehaviorRelay<String>, password: BehaviorRelay<String> , completion: @escaping (AuthDataResult? , Error?) -> Void)
    func signUp(email: BehaviorRelay<String>, password: BehaviorRelay<String> , completion: @escaping (AuthDataResult? , Error?)-> Void)
}


final class FirebaseAuthImplementation: FirebaseAuthRepo{
    
    func signIn(email: BehaviorRelay<String>, password: BehaviorRelay<String> , completion: @escaping (AuthDataResult? , Error?)-> Void) {
        Auth.auth().signIn(withEmail: email.value, password: password.value, completion: completion)
    }
    
    func signUp(email: BehaviorRelay<String>, password: BehaviorRelay<String>, completion: @escaping (AuthDataResult?, Error?)-> Void) {
        Auth.auth().createUser(withEmail: email.value, password: password.value, completion: completion)
    }
    

}

