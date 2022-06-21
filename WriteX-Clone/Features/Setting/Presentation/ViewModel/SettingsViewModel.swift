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


class SettingsViewModel{
    
    
    //MARK: - data
    private let useCase = SettingsUseCase()
    private let bag = DisposeBag()
    
    private var coordinator: SettingsCoordinator?
    
    //MARK: - Datasource
    let caseTableView = Observable.of([1,2,3,4])
    var dataSource = RxTableViewSectionedReloadDataSource<SectionDataSources<Int>> {_,_,_,_ in fatalError()}
    
    
    
    init(coordinator: SettingsCoordinator = SettingsCoordinator()){
        self.coordinator = coordinator
    }
    
    func didTabSelectedHiddenCell(){
        coordinator?.startHiddenCoordinator()
    }
    
    func didTablogOutCell(){
        
    }
}
