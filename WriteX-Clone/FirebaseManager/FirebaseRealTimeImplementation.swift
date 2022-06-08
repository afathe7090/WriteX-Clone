//
//  FirebaseRealTimeImplementation.swift
//  WriteX
//
//  Created by Ahmed Fathy on 08/06/2022.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa



protocol FirebaseRealTimeRepo {
    func write()
    func read()
    func update()
    func deleteAll()
    func deleteAt(index: Int)
}



final class FirebaseRealTimeImplementation: FirebaseRealTimeRepo {
    
    private var ref = Database.database().reference()
    
    func write() {
        
    }
    
    func read() {
        
    }
    
    func update() {
        
    }
    
    func deleteAll() {
        
    }
    
    func deleteAt(index: Int) {
        
    }
}
