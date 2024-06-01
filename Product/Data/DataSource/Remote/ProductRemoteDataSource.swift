//
//  ProductRemoteDataSource.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
class ProductRemoteDataSource {
    private let network: AlamofireNetwork = .shared
    static let shared = ProductRemoteDataSource()
    func getProductList(
        onSuccess : @escaping ([ProductVO]) -> (),
        onFailure : @escaping (String) -> ()
    ){
        network.request(
            endpoint: AlamofireProductEndpoint.GetAllProducts,
            onSuccess: { (response : ProductResponse) in
                if let data = response.products {
                    onSuccess(data)
                }else {
                    onFailure("Something went wrong!")
                }
            },
            onFailed: { error in
                switch error {
                case .UNEXPECTED_STATUS_CODE(let code):
                    onFailure(error.customMessage)
                default:
                    onFailure(error.customMessage)
                }
            })
    }
    
    func getProductDetail(
        with productId : String,
        onSuccess : @escaping (ProductVO) -> (),
        onFailure : @escaping (String) -> ()
    ){
        network.request(
            endpoint: AlamofireProductEndpoint.GetProdcutDetail(productId),
            onSuccess: { (response : ProductVO) in
                onSuccess(response)
            },
            onFailed: { error in
                switch error {
                case .UNEXPECTED_STATUS_CODE(let code):
                    onFailure(error.customMessage)
                default:
                    onFailure(error.customMessage)
                }
            })
    }
    
    func searchProduct(
        with productName : String,
        onSuccess : @escaping ([ProductVO]) -> (),
        onFailure : @escaping (String) -> ()
    ){
        network.request(
            endpoint: AlamofireProductEndpoint.SearchProduct(productName),
            onSuccess: { (response : ProductResponse) in
                if let data = response.products {
                    onSuccess(data)
                }else {
                    onFailure("Something went wrong!")
                }
            },
            onFailed: { error in
                switch error {
                case .UNEXPECTED_STATUS_CODE(let code):
                    onFailure(error.customMessage)
                default:
                    onFailure(error.customMessage)
                }
            })
    }
}
