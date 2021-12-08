//
//  Flovatar.swift
//  FCLDemo
//
//  Created by Yuriy Berdnikov on 30.11.2021.
//

import Foundation

struct Flovatar: Decodable, Hashable {
    var id: Int
    var name: String?
    var flowID: Int
    var flowAddress: String?
    var svg: String?

    let boosters: [Int] = [Int.random(in: 1..<10), Int.random(in: 1..<10), Int.random(in: 1..<10)]

    enum CodingKeys: String, CodingKey {
        case id, name
        case flowID = "flow_id"
        case flowAddress = "flow_address"
        case svg = "full_svg"
    }
}
