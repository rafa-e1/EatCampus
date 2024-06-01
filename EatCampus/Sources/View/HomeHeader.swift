//
//  HomeHeader.swift
//  EatCampus
//
//  Created by RAFA on 5/31/24.
//

import UIKit

import SnapKit
import Then

final class HomeHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    let searchBarButton = UIButton(type: .custom)
    let tabMenu = UISegmentedControl(items: ["전체보기", "카테고리"])
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupUI() {
        searchBarButton.do {
            var config = UIButton.Configuration.gray()
            config.title = "검색"
            config.image = UIImage(systemName: "magnifyingglass")
            config.imagePlacement = .leading
            config.imagePadding = 10
            
            $0.configuration = config
            $0.tintColor = .systemGray
            $0.contentHorizontalAlignment = .leading
            addSubview($0)
        }
        
        tabMenu.do {
            $0.selectedSegmentIndex = 0
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        searchBarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(20)
            $0.height.equalTo(40)
        }
        
        tabMenu.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(searchBarButton.snp.bottom).offset(10)
            $0.left.equalTo(searchBarButton)
        }
    }
}
