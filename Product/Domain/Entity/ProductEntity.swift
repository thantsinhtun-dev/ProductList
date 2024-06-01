//
//  ProductEntity.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
struct ProductEntity : Codable {
    let id : String
    let name : String
    let productDescription : String
    let category: String
    let brand : String
    let thumbnail : String
    let images : [String]
    let price : Double
}
