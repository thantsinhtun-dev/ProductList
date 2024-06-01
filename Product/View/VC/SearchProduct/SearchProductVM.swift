//
//  SearchProductVM.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
protocol SearchProductViewDelegate {
    func onGetProductList()
    func onGetError(message:String)
    func onLoading()
}
class SearchProductVM {
    private let repository = ProductRepository()
    private let delegate: SearchProductViewDelegate
    
    init(delegate: SearchProductViewDelegate) {
        self.delegate = delegate
    }

    private (set) var productList:[ProductEntity] = [] {
        didSet {
            if productList.isEmpty {
                delegate.onGetError(message: "empty data")
            }else{
                delegate.onGetProductList()
            }
        }
    }
    
    func searchProductList(with query:String){
        delegate.onLoading()
        repository.searchProduct(
            with: query,
            onSuccess: { [weak self] data in
                print("data",data.count)
                self?.productList = data
            }, onFailure: { [weak self] error in
                print("data error",error)

                self?.delegate.onGetError(message: error)
            })
    }
}
