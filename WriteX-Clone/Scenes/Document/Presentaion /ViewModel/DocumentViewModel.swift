//
//  DocumentViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 08/06/2022.
//

import Foundation
import Firebase
import RxCocoa
import RxSwift


class DocumentViewModel{
    
    private var coordinator: DocumentCoordinator?
    
    init(coordinator: DocumentCoordinator = DocumentCoordinator()){
        self.coordinator = coordinator
    }
    
}

