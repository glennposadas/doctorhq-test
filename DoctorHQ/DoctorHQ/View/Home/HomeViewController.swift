//
//  HomeViewController.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Functions
    
    private func setupBindings() {
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
    }
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.0)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

    }
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HomeViewModel(homeController: self)
        
        self.setupUI()
        self.setupBindings()
    }
}

// MARK: - HomeDelegate

extension HomeViewController: HomeDelegate {
    func showCityList() {
        let cityListController = CityListViewController()
        self.navigationController?.pushViewController(cityListController, animated: true)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
