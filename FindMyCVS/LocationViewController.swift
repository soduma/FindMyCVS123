//
//  LocationViewController.swift
//  FindMyCVS
//
//  Created by 장기화 on 2022/01/06.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import SnapKit

class LocationViewController: UIViewController, MTMapViewDelegate {
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    let mapView = MTMapView()
    let currentLocationButton = UIButton()
    let detailList = UITableView()
    let viewModel = LocationViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bind(viewModel)
        configure()
        layout()
    }
    
    func bind(_ viewModel: LocationViewModel) {
        currentLocationButton.rx.tap
            .bind(to: viewModel.tapCurrentLocationButton)
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        navigationItem.title = "내 편의점 찾기"
        mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
        mapView.delegate = self
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.backgroundColor = .white
        currentLocationButton.layer.cornerRadius = 20
    }
    
    private func layout() {
        [mapView, currentLocationButton, detailList]
            .forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.snp.centerY).offset(100)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.bottom.equalTo(detailList.snp.top).offset(-12)
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(40)
        }
        
        detailList.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(mapView.snp.bottom)
        }
    }
}

