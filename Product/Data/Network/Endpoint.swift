//
//  Endpoint.swift
//  BookStore
//
//  Created by Phyo Thiha on 5/4/24.
//

import Foundation

protocol Endpoint {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod:HTTPMethod {get}
    var paramter:[String:Any]? {get}
    var encoding: HTTPEncoding {get}
    var header: [String: String]? {get}
//    
//    Base url => {{baseUrl}}/api
//    Path => /user/books
//    
//    URL => Base url + Path => Invalid URL Exception
//    
    func asURL() throws -> URL
}

extension Endpoint {
    
    //1. Property List ( Info.plist ) => Unsecured ==> .ipa
    //2. Reading info.plist => Bundle.main
    var baseURL: URL {
        URL(string: Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "")!
    }
    
    func asURL() throws -> URL {
        return baseURL.appending(path: path)
    }
    
}
