//
//  AlamofireEndpoint.swift
//  BookStore
//
//  Created by Phyo Thiha on 5/18/24.
//

import Foundation
import Alamofire

protocol AlamofireEndpoint: URLConvertible {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod:Alamofire.HTTPMethod {get}
    var paramter:Parameters? {get}
    var encoding: ParameterEncoding {get}
    var header: HTTPHeaders? {get}
}

extension AlamofireEndpoint {
    
    //1. Property List ( Info.plist ) => Unsecured ==> .ipa
    //2. Reading info.plist => Bundle.main
    var baseURL: URL {
        URL(string: Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "")!
    }
    
    func asURL() throws -> URL {
        return baseURL.appending(path: path)
    }
    
}
