//
//  ViewController.swift
//  FindMyCVS
//
//  Created by 장기화 on 2022/01/06.
//

import UIKit
import SnapKit

class ViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?
    private lazy var typeChangeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "map.fill"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MTMapView(frame: view.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            view.addSubview(mapView)
            view.addSubview(typeChangeButton)
            typeChangeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        }
        
        typeChangeButton.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.width.height.equalTo(50)
        }
    }
    
    @objc func tapButton() {
        if mapView?.baseMapType == .standard {
            mapView?.baseMapType = .hybrid
        } else if mapView?.baseMapType == .hybrid {
            mapView?.baseMapType = .satellite
        } else {
            mapView?.baseMapType = .standard
        }
    }
}

