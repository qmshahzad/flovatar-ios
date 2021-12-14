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
    var rareCount: Int = 0
    var legendaryCount: Int = 0
    var epicCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case id, name
        case flowID = "flow_id"
        case flowAddress = "flow_address"
        case svg = "full_svg"
        case rareCount = "rare_count"
        case legendaryCount = "legendary_count"
        case epicCount = "epic_count"
    }
}
