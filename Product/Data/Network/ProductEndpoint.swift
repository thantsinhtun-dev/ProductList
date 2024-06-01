//
//  BookStoreEndpoint.swift
//  BookStore
//
//  Created by Phyo Thiha on 5/4/24.
//

import Foundation
import Alamofire

enum AlamofireProductEndpoint: AlamofireEndpoint {

    case GetAllProducts
    case GetProdcutDetail(Encodable)
    case SearchProduct(Encodable)
    
    var path: String {
        switch self {
        case .GetAllProducts:
            return "/products"
        case .GetProdcutDetail(let productId):
            return "/products/\(productId)"
        case .SearchProduct:
            return "/products/search"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .GetAllProducts,.GetProdcutDetail,.SearchProduct:
            return .get
        }
    }
    
    var paramter: Alamofire.Parameters? {
        switch self {
        case .GetProdcutDetail, .GetAllProducts:
           return nil
        case .SearchProduct(let productName):
            return ["q":productName]
        }
    }
    
    var encoding: any Alamofire.ParameterEncoding {
        switch self {
        case .GetAllProducts,.GetProdcutDetail:
            return JSONEncoding.default
        case .SearchProduct:
            return URLEncoding.queryString
            
        }
    }
    
    var header: Alamofire.HTTPHeaders? {
        switch self {
        case .GetAllProducts,.GetProdcutDetail,.SearchProduct:
            return nil
        }
    }
    
}


extension Encodable {
    func toDict() -> [String:Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dic ?? [:]
        } catch {
            return [:]
        }
    }
}
