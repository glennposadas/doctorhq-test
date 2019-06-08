//
//  CityListViewModel.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

/// The delegate of the ```CityListViewModel```
protocol CityListDelegate: class {
    func reloadData()
    func goToHome()
    func presentAlert(message: String, okayButtonTitle: String)
}

class CityListViewModel: NSObject {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: CityListDelegate?
    
    var isSearching = BehaviorRelay<Bool>(value: true)
    var cities = BehaviorRelay<[City]>(value: [])
    var lastSearchQuery = BehaviorRelay<String>(value: ".....")
    var searchQuery = BehaviorRelay<String>(value: "")
    
    // MARK: Functions
    
    /// Start searching
    private func search(_ query: String) {
        if query == self.lastSearchQuery.value {
            return
        }
        
        print("Searching... \(query) ✍🏻")
        
        self.lastSearchQuery.accept(query)
        self.isSearching.accept(true)
        
        APIManager.SearchCalls.search(query, onSuccess: { (newCities) in
            self.lastSearchQuery.accept(".....")
            self.isSearching.accept(false)
            
            if let newCities = newCities {
                self.cities.accept(newCities)
                self.delegate?.reloadData()
            }
        }, onError: { errorMessage, _, _ in
            self.isSearching.accept(false)
            self.lastSearchQuery.accept(".....")
            self.delegate?.presentAlert(message: errorMessage, okayButtonTitle: "OK")
        })
    }
    
    /// init
    init(cityListController: CityListDelegate) {
        super.init()
        
        self.delegate = cityListController
        self.search("")
        
        self.searchQuery.subscribe(onNext: { [weak self] newQuery in
            guard let strongSelf = self else { return }
            strongSelf.search(newQuery)
        }).disposed(by: self.disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension CityListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Select and add city to shared data
        let city = self.cities.value[indexPath.row]
        LTSharedData.selectedCities.accept(LTSharedData.selectedCities.value + [city])
        self.delegate?.goToHome()
    }
}

// MARK: - UITableViewDataSource

extension CityListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CityTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell
        
        if cell == nil {
            cell = CityTableViewCell()
        }
        
        let city = self.cities.value[indexPath.row]
        cell?.setupCell(city)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.value.count
    }
}
