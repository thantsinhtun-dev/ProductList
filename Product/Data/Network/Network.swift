//
//  Network.swift
//  BookStore
//
//  Created by Phyo Thiha on 4/27/24.
//

import Foundation

class Network {
    
    static let shared: Network = .init()
    
    private init() {}
    
    //Endpoint => url, method,contentType,requestBody
    func request<T:Codable>(
        endpoint: Endpoint,
        onSuccess:@escaping(T) -> (),
        onFailed:@escaping(NetworkError) -> ()
    )  {
        
        let url:URL? = try? endpoint.asURL()//nil or value
        
        guard let url = url else {
            onFailed(.INVALID_URL)
            return
        }
        
        //T => [PostVO]
        var request = URLRequest.init(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        //1.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //if user login -> add token to header
        //2.
//        if let token = KeychainManager.shared.getAccessToken(), !token.isEmpty {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        
        if let requestBody = endpoint.paramter {
            
            switch endpoint.encoding {
            case .JSON:
                let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            case .QUERY_STRING:
                //parameter [String:Any] => [URLQueryItem]
                // [Int] => [String]
                // Int -> String
                // [Int] -> [String]
                request.url = request.url?.appending(queryItems: requestBody.map{
                    URLQueryItem.init(name: $0.key, value: String(describing: $0.value))
                })
            }
        }
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                onFailed(.UNKNOWN)
            } else {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if (200..<300) ~= statusCode {
                        if let data = data {
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
        }.resume()
        
    }
}
