//
//  LocationModelTests.swift
//  FindMyCVSTests
//
//  Created by 장기화 on 2022/01/09.
//

import XCTest
import Nimble

@testable import FindMyCVS

class LocationModelTests: XCTestCase {
    let stubNetwork = LocalNetworkStub()
    
    var doc: [KLDocument]!
    var model: LocationModel!
    
    override func setUp() {
        self.model = LocationModel(localNetwork: stubNetwork)
        self.doc = cvsList
    }
    
    func testDocumentsToCellData() {
        let cellData = model.documentsToCellData(doc) //실제 모델의 값
        let placeName = doc.map { $0.placeName } //더미의 값
        let address0 = cellData[1].address //실제 모델의 값
        let roadAddressName = doc[1].roadAddressName //더미의 값
        
        expect(cellData.map { $0.placeName })
            .to(equal(placeName), description: "DetailListCellData의 placeName은 document의 placeName이다.")
        
        expect(address0)
            .to(equal(roadAddressName), description: "KLDocument의 RoadAddressName이 빈 값이 아닐 경우 RoadAddress가 cellData에 전달된다.")
    }
}
