//
//  LocationViewModel.swift
//  FindMyCVS
//
//  Created by 장기화 on 2022/01/07.
//

import UIKit
import RxSwift
import RxCocoa

struct LocationViewModel {
    let tapCurrentLocationButton = PublishRelay<Void>()
}
