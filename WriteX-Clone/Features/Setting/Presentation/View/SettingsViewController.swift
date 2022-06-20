//
//  SettingsViewController.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewController: UIViewController {
    
    
    //MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var hidenNotesCell: UITableViewCell!
    @IBOutlet var emailTableViewCell: UITableViewCell!
    @IBOutlet var logOutCell: UITableViewCell!
    @IBOutlet var darkModelCell: UITableViewCell!
    @IBOutlet weak var emailOfUserLabel: UILabel!
    @IBOutlet weak var switchDarkMode: UISwitch!
    
    //MARK: - ViewModel
    
    private let viewModel: SettingsViewModel!
    private let bag = DisposeBag()
    
    
    //MARK: - Initialisation
    init( viewModel: SettingsViewModel = SettingsViewModel()){
        self.viewModel = viewModel
        super.init(nibName: "SettingsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        tableViewDataSsource()
        configurationDataSource()
    }
    
    //MARK: - Helper FUnctions
    fileprivate func configureNavigationController(){
        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: - Datasource
    
    
    fileprivate func tableViewDataSsource(){
        viewModel.dataSource.configureCell = {[weak self] (_ , _, indexPath , _) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            if (indexPath.section == 0) && (indexPath.row == 0) { return self.emailTableViewCell}
            if (indexPath.section == 0) && (indexPath.row == 1) { return self.hidenNotesCell}
            if (indexPath.section == 0) && (indexPath.row == 2) { return self.darkModelCell}
            if (indexPath.section == 0) && (indexPath.row == 3) { return self.logOutCell}
            return UITableViewCell()
        }
    }
    
    fileprivate func configurationDataSource(){
        viewModel.caseTableView
            .map({[SectionDataSources(header: "", items: $0)]})
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
    }
}



