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
        self.title = "Nearby".localized()
        
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
    func reloadData() {
        self.tableView.reloadData()
    }
}
