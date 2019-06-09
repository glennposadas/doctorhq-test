//
//  APIManager+OrgCalls.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import Result

extension APIManager {
    /// All Org related calls
    class OrgCalls: Base {
        
        /// Call back for methods with call backs that contain array of `Organisation` objects.
        typealias OrganisationsCallBack = ((_ organisations: [Organisation]?) -> Void)
        
        /*
         static let stubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.immediatelyStub)
         static let delayedStubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.delayedStub(3.0))
         static let provider: MoyaProvider<OrderService> = delayedStubbingProvider//LLFEnv.llfEnvType == .unitTesting ? stubbingProvider : authServiceProvider*/
        
        /// Get all the nearby ogranisations
        static func getNearestOrganisations(
            latitude: Double,
            longitude: Double,
            distance: Int = 100,
            onSuccess: @escaping OrganisationsCallBack,
            onError: ErrorCallBack = nil) {
            self.request(
                provider: orgServiceProvider,
                target: .getNearestOrganisations(latitude: latitude, longitude: longitude, distance: distance),
                onSuccess: { (data) in
                    let newOrgs = try? JSONDecoder().decode([Organisation].self, from: data)
                    onSuccess(newOrgs)
            }, onError: onError)
        }
    }
}


