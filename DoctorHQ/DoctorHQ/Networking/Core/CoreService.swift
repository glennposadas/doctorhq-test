//
//  CoreService.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Moya

/// Contains all static URL String of the whole service.
/// Values will vary based on the DHQEnv.
/// TODO: Setup DHQEnv (Dev, Staging, Production)
struct APIUrl {
    /// Complete base url of the API.
    static var baseURLString: String {
        get {
            return "\(APIUrl.host)\(APIUrl.apiVersion)"
        }
    }
    
    /// The host URL String
    static var host: String {
        get {
            return "https://staging.dochq.co.uk"
        }
    }
    
    /// The API version
    static var apiVersion: String {
        get {
            return "/api/v2"
        }
    }
}

/// Helper function
public func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

/// Moya Manager
let moyaManager = Manager(
    configuration: URLSessionConfiguration.default,
    serverTrustPolicyManager: CustomServerTrustPoliceManager()
)

/// The core class of DHQ networking
/// The constants for networking is stored in the file ```CoreService.swift```.
class CoreService {
    
    /// Determines if each managers call the API verbosely.
    static var verbose: Bool = false
    
    /// Generates a bearer token.
    class func getBearerToken() -> String? {
        return ""
    }
    
    /// Generates required headers for all API endpoints.
    class func getHeaders() -> [String : String] {
        return [
            "Content-type"  : "application/json",
        ]
    }
}

