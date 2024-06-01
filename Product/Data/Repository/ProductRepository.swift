//
//  ProductRepository.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
class ProductRepository {
    static let shared = ProductRepository()
    private let productRemoteDataSource = ProductRemoteDataSource.shared
   
    
    func getProductList(
        onSuccess : @escaping ([ProductEntity]) -> (),
        onFailure : @escaping (String) -> ()
    ){
        productRemoteDataSource.getProductList(
            onSuccess: { data in
                onSuccess(data.map{$0.toEntity()})
            }, onFailure: onFailure
        )
    }
    
    func getProductDetail(
        with productId : String,
        onSuccess : @escaping (ProductEntity) -> (),
        onFailure : @escaping (String) -> ()
    ){
        productRemoteDataSource.getProductDetail(
            with: productId,
            onSuccess: { data in
                onSuccess(data.toEntity())
            }, onFailure: onFailure
        )
    }
    
    func searchProduct(
        with productName : String,
        onSuccess : @escaping ([ProductEntity]) -> (),
        onFailure : @escaping (String) -> ()
    ){
        productRemoteDataSource.searchProduct(
            with: productName,
            onSuccess: { data in
                onSuccess(data.map{$0.toEntity()})
            }, onFailure: onFailure
        )
    }
}
