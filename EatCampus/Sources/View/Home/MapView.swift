//
//  MapView.swift
//  EatCampus
//
//  Created by RAFA on 6/3/24.
//

import UIKit

import NMapsMap
import SnapKit
import Then

final class MapView: UIView {
    
    // MARK: - Properties
    
    let naverMapView = NMFNaverMapView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        naverMapView.do {
            $0.showLocationButton = true
            $0.showZoomControls = false
            $0.showIndoorLevelPicker = true
            $0.mapView.isNightModeEnabled = true
            $0.mapView.positionMode = .direction
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        naverMapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
