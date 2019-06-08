//
//  LTSharedData.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

class LTSharedData {
    /// The collection of selected cities, used by `HomeViewModel`.
    /// Todo: consider storing this to CoreData.
    static var selectedCities = BehaviorRelay<[City]>(value: [])
}
