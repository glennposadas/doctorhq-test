//
//  HomeViewModel.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import CoreLocation
import Foundation
import MapKit
import Moya
import RxCocoa
import RxSwift

/// The delegate of the ```HomeViewModel```
protocol HomeDelegate: class {
    func reloadData()
}

class HomeViewModel: NSObject {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    weak var delegate: HomeDelegate?
    
    private var organisations = [Organisation]()
    
    var currentLocation = BehaviorRelay<CLLocation?>(value: nil)
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.pausesLocationUpdatesAutomatically = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 50
        return manager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    // MARK: Functions
    
    /// Let the controller show the no location views
    /// and hide the main views.
    private func noLocation() {
        
    }

    /// init
    init(homeController: HomeDelegate?) {
        super.init()
        
        self.delegate = homeController
        self.locationManager.startUpdatingLocation()
        
        self.currentLocation.subscribe(onNext: { [weak self] newLocation in
            
            guard let strongSelf = self else { return }
            
            APIManager.OrgCalls.getNearestOrganisations(
                latitude: newLocation?.coordinate.latitude ?? 0.0,
                longitude: newLocation?.coordinate.longitude ?? 0.0, onSuccess: { (organisations) in
                    guard let organisations = organisations else { return }
                    strongSelf.organisations = organisations
                    strongSelf.delegate?.reloadData()
            })
        }).disposed(by: self.disposeBag)
    }
}

// MARK: - CLLocationManagerDelegate

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        self.currentLocation.accept(lastLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: break
        default: self.noLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

// MARK: - UITableViewDelegate

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

// MARK: - UITableViewDataSource

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: OrganisationTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: OrganisationTableViewCell.identifier, for: indexPath) as? OrganisationTableViewCell
        
        if cell == nil {
            cell = OrganisationTableViewCell()
        }
        
        let row = indexPath.row
        
        let org = self.organisations[row]
        cell?.setupCell(org)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organisations.count
    }
}
