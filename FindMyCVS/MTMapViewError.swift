//
//  MTMapViewError.swift
//  FindMyCVS
//
//  Created by 장기화 on 2022/01/07.
//

import Foundation

enum MTMapViewError: Error {
    case failedUpdatingCurrentLocation
    case locationAuthorizationDenied
    
    var errorDescription: String {
        switch self {
        case .failedUpdatingCurrentLocation:
            return "현재 위치를 모르겠어요. 다시 시도!"
        case .locationAuthorizationDenied:
            return "위치를 비활성화하면 못 찾아요!"
        }
    }
}
