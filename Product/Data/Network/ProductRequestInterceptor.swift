//
//  BookstoreRequestInterceptor.swift
//  BookStore
//
//  Created by Phyo Thiha on 5/18/24.
//

import Foundation
import Alamofire

class ProductRequestInterceptor: RequestInterceptor {
    
    // Intercepts the Requests from AlamfoireNetwork.swift
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        
        //Login, Register => No Token
        // Book => Token
        
        //1 How do we know if urlRequest ==Login || Register || Book ??
        // /api/uer/books => "/user/books"
        // replace => "/api" => "" => "/user/books"
        
        var request = urlRequest
        
        let url = request.url?.path(percentEncoded: false)
        
//        switch url {
//        case AlamofireProductEndpoint.Login(0).path,
//            AlamofireProductEndpoint.Register(0).path:
//            break
//        default:
//            if let token = KeychainManager.shared.getAccessToken(), !token.isEmpty {
//                request.headers.add(
//                    .authorization(bearerToken: token)
//                )
//            }
//            break
//        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        if request.response?.statusCode == 401 {
            print("Token Expired")
            //Send out global event
            NotificationCenter.default.post(name: .TokenExpiredNotification, object: nil)
        }
        completion(.doNotRetry)
    }
}

extension NSNotification.Name {
    static var TokenExpiredNotification = NSNotification.Name("token_expired")
}
