//
//  ProductDetailVM.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation

protocol ProductDetailViewDelegate {
    func onGetProductDetail()
    func onGetError(message:String)

}
class ProductDetailVM {
    private let repository = ProductRepository()
    private let delegate: ProductDetailViewDelegate
    
    init(delegate: ProductDetailViewDelegate) {
        self.delegate = delegate
    }

    private (set) var productEntity:ProductEntity?{
        didSet {
           delegate.onGetProductDetail()
        }
    }
    
    func fetchProductDetil(with productId:String){
        print("id ",productId)
        repository.getProductDetail(
            with: productId,
            onSuccess: { [weak self] data in
                self?.productEntity = data
            }, onFailure: { [weak self] error in
                print(error)
                self?.delegate.onGetError(message: error)
            })
    }
}
