//
//  OrgService.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya

/// Provider for OrdgService.
let orgServiceProvider = MoyaProvider<OrgService>(
    manager: moyaManager,
    plugins: [NetworkLoggerPlugin(verbose: CoreService.verbose)]
)

/// The service for all the Organisation related calls.
enum OrgService {
    /// Get the nearby org.
    case getNearestOrganisations(latitude: Double, longitude: Double, distance: Int)
}

// MARK: - TargetType Protocol Implementationm

extension OrgService: TargetType {
    var baseURL: URL {
        return URL(string: APIUrl.baseURLString)!
    }
    
    var path: String {
        switch self {
        case let .getNearestOrganisations(latitude, longitude, _):
            return "/organizations/organisation/latlon/\(latitude)/\(longitude)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNearestOrganisations: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getNearestOrganisations: return stubbedResponse("Organisations")
        }
    }

    var task: Task {
        switch self {
        case let .getNearestOrganisations(_, _, distance):
            return .requestParameters(
                parameters: [
                    "distance": distance
                ], encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return CoreService.getHeaders()
    }
}





