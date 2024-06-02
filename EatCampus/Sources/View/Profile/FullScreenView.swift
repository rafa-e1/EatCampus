//
//  FullScreenView.swift
//  EatCampus
//
//  Created by RAFA on 6/2/24.
//

import UIKit

import SnapKit
import Then

final class FullScreenView: UIView {
    
    // MARK: - Properties
    
    let closeButton = UIButton(type: .system)
    let imageView = UIImageView()
    
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
        closeButton.do {
            $0.setImage(
                UIImage(systemName: "xmark")?
                    .withTintColor(.white, renderingMode: .alwaysOriginal)
                    .applyingSymbolConfiguration(
                        UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
                    ),
                for: .normal
            )
            imageView.addSubview($0)
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .black
            $0.isUserInteractionEnabled = true
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.equalTo(20)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
