//
//  CityListViewController.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class CityListViewController: BaseViewController {

    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: CityListViewModel!

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a city".localized()
        searchBar.setPositionAdjustment(UIOffset(horizontal: 35.0, vertical: 0), for: .search)
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private lazy var view_TopSeparator: UIView = {
        return UIView.new(backgroundColor: .lightGray)
    }()
    
    // MARK: - Functions
    
    private func setupBindings() {
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        
        self.viewModel.isSearching
            .bind(to: self.tableView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .bind(to: self.viewModel.searchQuery)
            .disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        self.view.addSubviews(
            self.searchBar,
            self.button_Back,
            self.view_TopSeparator,
            self.activityIndicator,
            self.tableView
        )
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.button_Back.snp.makeConstraints {
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(8.0)
            $0.centerY.equalTo(self.searchBar)
            $0.width.height.equalTo(44.0)
        }

        self.view_TopSeparator.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.searchBar.snp.bottom)
        }

        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view_TopSeparator.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

        self.activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

    }
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = CityListViewModel(cityListController: self)
        self.setupUI()
        self.setupBindings()
    }
}

// MARK: - CityListDelegate

extension CityListViewController: CityListDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func goToHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentAlert(message: String, okayButtonTitle: String) {
        self.alert(message: message, okayButtonTitle: okayButtonTitle)
    }
}
