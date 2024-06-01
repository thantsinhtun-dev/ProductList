//
//  AlamofireNetwork.swift
//  BookStore
//
//  Created by Phyo Thiha on 5/18/24.
//

import Foundation
import Alamofire

class AlamofireNetwork {
    
    static let shared: AlamofireNetwork = .init()
    private let session: Session
    
    private init() {
        session = Session(interceptor: ProductRequestInterceptor())
    }
    
    //Endpoint => url, method,contentType,requestBody
    func request<T:Codable>(
        endpoint: AlamofireEndpoint,
        onSuccess:@escaping(T) -> (),
        onFailed:@escaping(NetworkError) -> ()
    ) {
        //AF.request => new AF Session x 10 => Shared Session AF => Session => API
        session
            .request(
                endpoint,
                method: endpoint.httpMethod,
                parameters: endpoint.paramter,
                encoding: endpoint.encoding,
                headers: endpoint.header
            )
            .validate({ request, response, data in
                //Result<Void, Error>
                if response.statusCode == 401 {
                    //failed
                    return .failure(NetworkError.UNEXPECTED_STATUS_CODE(response.statusCode))
                } else {
                    //success
                    return .success(())
                }
                //if 401 => Failed
                // else => Success
            })
            .response { afResponse in
                //401,200,201,500
                if let statusCode = afResponse.response?.statusCode {
                    if (200..<300) ~= statusCode {
                        if let data = afResponse.data {
                            print(data)
                            //[PostVO] = T, T.self => [PostVO].self
                            let object:T? =  try? JSONDecoder().decode(T.self, from: data)
                            if let object = object {
                                onSuccess(object)
                            } else {
                                onFailed(.DECODE_ERROR)
                            }
                        } else {
                            onFailed(.EMPTY_RESPONSE)
                        }
                       
                    } else {
                        //error response decode => Rep
                        onFailed(.UNEXPECTED_STATUS_CODE(statusCode))
                    }
                } else {
                    onFailed(.EMPTY_RESPONSE)
                }
            }
    }
}
