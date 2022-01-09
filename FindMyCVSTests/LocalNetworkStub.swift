//
//  LocalNetworkStub.swift
//  FindMyCVSTests
//
//  Created by 장기화 on 2022/01/09.
//

import Foundation
import RxSwift
import Stubber

@testable import FindMyCVS

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
