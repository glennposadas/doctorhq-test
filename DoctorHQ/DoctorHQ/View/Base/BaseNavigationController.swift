//
//  BaseNavigationController.swift
//  DoctorHQ
//
//  Created by Glenn Posadas on 6/9/19.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    // MARK: - Properties
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.prefersLargeTitles = true
    }
}
