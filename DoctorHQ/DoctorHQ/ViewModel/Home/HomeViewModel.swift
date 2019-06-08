//
//  HomeViewModel.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

enum HomeSectionType: Int {
    case selectCity = 0
    case selectedCities
    
    static let count: Int = 2
}

/// The delegate of the ```HomeViewModel```
protocol HomeDelegate: class {
    func showCityList()
    func reloadData()
}

class HomeViewModel: NSObject {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    weak var delegate: HomeDelegate?
    
    // MARK: Functions
    
    /// init
    init(homeController: HomeDelegate?) {
        super.init()
        
        self.delegate = homeController
        
        LTSharedData.selectedCities.subscribe(onNext: { [weak self] cities in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: Button Events
    
    /// Selector for select city button.
    /// Update: button was changed to tableViewCell.
    func selectCity() {
        self.delegate?.showCityList()
    }
    
}

// MARK: - UITableViewDelegate

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        
        if let homeSectionType = HomeSectionType(rawValue: section) {
            switch homeSectionType {
            case .selectCity: self.selectCity()
            case .selectedCities: break
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: HomeTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        
        if cell == nil {
            cell = HomeTableViewCell()
        }
        
        let section = indexPath.section
        let row = indexPath.row
        
        if let homeSectionType = HomeSectionType(rawValue: section) {
            switch homeSectionType {
            case .selectCity:
                cell?.setupCell(nil)
            case .selectedCities:
                cell?.setupCell(LTSharedData.selectedCities.value[row])
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let homeSectionType = HomeSectionType(rawValue: section) {
            switch homeSectionType {
            case .selectCity: return 1
            case .selectedCities: return LTSharedData.selectedCities.value.count
            }
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.count
    }
}
