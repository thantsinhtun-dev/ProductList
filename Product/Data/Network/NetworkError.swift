//
//  NetworkError.swift
//  BookStore
//
//  Created by Phyo Thiha on 5/5/24.
//

import Foundation

//API Specific Error => Domain Specific Error (Map) => Datasource
enum NetworkError: Error {
    case INVALID_URL
    case UNKNOWN
    case DECODE_ERROR
    case EMPTY_RESPONSE
    case UNEXPECTED_STATUS_CODE(Int)
    
    var customMessage: String {
        switch self {
        case .INVALID_URL:
            "Invalid Url"
        case .UNKNOWN:
            "Something went wrong"
        case .DECODE_ERROR:
            "Decode error"
        case .EMPTY_RESPONSE:
            "Empty Response"
        case .UNEXPECTED_STATUS_CODE:
            "Invalid Status Code"
        }
    }
}
