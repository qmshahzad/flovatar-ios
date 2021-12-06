//
//  PaginatedResponse.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 06.12.2021.
//

import Foundation

struct PaginatedResponse<T: Decodable & Hashable>: Decodable, Hashable {
    var id: Int {
        currentPage
    }

    let currentPage: Int
    let lastPage: Int
    let data: [T]

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case data
    }
}
