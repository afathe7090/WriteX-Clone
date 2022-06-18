//
//  LoginRepo.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol LoginRepo{
    func signIn(email: BehaviorRelay<String>, password: BehaviorRelay<String> ,completion: @escaping (AuthDataResult?, Error?) -> Void)
}
