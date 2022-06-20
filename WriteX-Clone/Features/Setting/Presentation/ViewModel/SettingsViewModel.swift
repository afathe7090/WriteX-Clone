//
//  SettingsViewModel.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 20/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

enum CaseTableView{
    case email
    case hidden
    case darkModel
    case logOut
    
}

class SettingsViewModel{
    
    private let useCase = SettingsUseCase()
    private let bag = DisposeBag()
    
    let caseTableView = Observable.of([1,2,3,4])
    
    var dataSource = RxTableViewSectionedReloadDataSource<SectionDataSources<Int>> {_,_,_,_ in fatalError()}
    
    
    
    init(){
        
    }
    
    
    
    
}
