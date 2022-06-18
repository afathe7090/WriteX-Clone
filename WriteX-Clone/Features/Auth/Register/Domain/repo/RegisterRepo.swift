//
//  RegisterRepo.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol RegisterRepo {
    func signUp(email: BehaviorRelay<String> ,
                password: BehaviorRelay<String> ,
                comletion: @escaping( AuthDataResult? , Error?) -> Void)
}
