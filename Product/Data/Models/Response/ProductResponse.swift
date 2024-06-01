//
//  ProductResponse.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
struct ProductResponse : Codable {
    let products: [ProductVO]?
    let total, skip, limit: Int?
}

struct ProductVO : Codable {
    let id: Int?
    let title, description: String?
    let category: String?
    let price, discountPercentage, rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand, sku: String?
    let weight: Int?
    let dimensions: Dimensions?
    let warrantyInformation, shippingInformation: String?
    let availabilityStatus: AvailabilityStatus?
    let reviews: [ReviewVO]?
    let returnPolicy: String?
    let minimumOrderQuantity: Int?
    let meta: MetaVO?
    let images: [String]?
    let thumbnail: String?
    
    
    func toEntity() -> ProductEntity {
        ProductEntity(
            id : String(id ?? 0),
            name: title ?? "",
            productDescription: description ?? "",
            category: category ?? "",
            brand: brand ?? "",
            thumbnail: thumbnail ?? "",
            images: images ?? [],
            price: price ?? 0.0
        )
    }
}

// MARK: - Review
struct ReviewVO: Codable {
    let rating: Int?
    let comment: String?
    let date: String?
    let reviewerName, reviewerEmail: String?
}

// MARK: - Meta
struct MetaVO: Codable {
    let createdAt, updatedAt: String?
    let barcode: String?
    let qrCode: String?
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let width, height, depth: Double?
}


enum AvailabilityStatus: String, Codable {
    case inStock = "In Stock"
    case lowStock = "Low Stock"
}

enum Category: String, Codable {
    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
}
