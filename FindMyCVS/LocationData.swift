//
//  LocationData.swift
//  FindMyCVS
//
//  Created by 장기화 on 2022/01/06.
//

import Foundation

struct LocationData: Codable {
    let documents: [KLDocument]
}

struct KLDocument: Codable {
    let placeName: String
    let addressName: String
    let roadAddressName: String
    let x: String
    let y: String
    let distance: String
    
    enum CodingKeys: String, CodingKey {
        case x, y, distance
        case placeName = "place_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
    }
}
