//
//  LocationViewModelTests.swift
//  FindMyCVSTests
//
//  Created by 장기화 on 2022/01/09.
//

import XCTest
import Nimble
import RxSwift
import RxTest

@testable import FindMyCVS

class LocationViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    let stubNetwork = LocalNetworkStub()
    
    var model: LocationModel!
    var viewModel: LocationViewModel!
    var doc: [KLDocument]!
    
    override func setUp() {
        self.model = LocationModel(localNetwork: stubNetwork)
        self.viewModel = LocationViewModel(model: model)
        self.doc = cvsList
    }
    
    func testSetMapCenter() {
        let scheduler = TestScheduler(initialClock: 0)
        
        //더미 데이터 이벤트
        let dummyDataEvent = scheduler.createHotObservable([
            .next(0, cvsList)
        ])
        
        let documentData = PublishSubject<[KLDocument]>()
        dummyDataEvent
            .subscribe(documentData)
            .disposed(by: disposeBag)
        
        //DetailList 아이템(셀) 탭 이벤트
        let itemSelectedEvent = scheduler.createHotObservable([
            .next(1, 0)
        ])
        
        let itemSelected = PublishSubject<Int>()
        itemSelectedEvent
            .subscribe(itemSelected)
            .disposed(by: disposeBag)
        
        let selectedItemMapPoint = itemSelected
            .withLatestFrom(documentData) { $1[0] }
            .map(model.documentToMTMapPoint)
        
        //최초 현재 위치 이벤트
        let initialMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(37.48552888657456), longitude: Double(126.92992641278093)))!
        let currentLocationEvent = scheduler.createHotObservable([
            .next(0, initialMapPoint)
        ])
        
        let initialCurrentLocation = PublishSubject<MTMapPoint>()
        
        currentLocationEvent
            .subscribe(initialCurrentLocation)
            .disposed(by: disposeBag)
        
        //현재 위치 버튼 탭 이벤트
        let currentLocationButtonTapEvent = scheduler.createHotObservable([
            .next(2, Void()),
            .next(3, Void())
        ])
        
        let currentLocationButtonTapped = PublishSubject<Void>()
        
        currentLocationButtonTapEvent
            .subscribe(currentLocationButtonTapped)
            .disposed(by: disposeBag)
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(initialCurrentLocation)
        
        //merge
        let currentMapCenter = Observable
            .merge(selectedItemMapPoint,
                   initialCurrentLocation.take(1),
                   moveToCurrentLocation)
        
        let currentMapCenterObserver = scheduler.createObserver(Double.self)
        
        currentMapCenter
            .map { $0.mapPointGeo().latitude }
            .subscribe(currentMapCenterObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let secondMapPoint = model.documentToMTMapPoint(doc[0])
        
        expect(currentMapCenterObserver.events)
            .to(equal([
                .next(0, initialMapPoint.mapPointGeo().latitude),
                .next(1, secondMapPoint.mapPointGeo().latitude),
                .next(2, initialMapPoint.mapPointGeo().latitude),
                .next(3, initialMapPoint.mapPointGeo().latitude)
            ])
            )
    }
}
