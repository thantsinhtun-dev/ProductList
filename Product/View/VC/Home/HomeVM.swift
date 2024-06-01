//
//  HomeVM.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
protocol HomeViewDelegate {
    func onGetProductList()
    func loading()
    func onGetError(message:String)
}
class HomeVM {
    
    private let repository = ProductRepository()
    private let delegate: HomeViewDelegate
    
    init(delegate: HomeViewDelegate) {
        self.delegate = delegate
    }

    private (set) var productList:[ProductEntity] = [] {
        didSet {
           delegate.onGetProductList()
        }
    }
    
    func fetchProductList(){
        delegate.loading()
        repository.getProductList(
            onSuccess: { [weak self] data in
                print("data",data.count)
                self?.productList = data
            }, onFailure: { [weak self] error in
                print("data error",error)

                self?.delegate.onGetError(message: error)
            })
    }
}
