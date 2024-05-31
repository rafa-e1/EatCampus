//
//  ProfileHeader.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView = UIImageView()
    private let fullnameLabel = UILabel()
    private var postsLabel = UILabel()
    private var followersLabel = UILabel()
    private let userInfoStackView = UIStackView()
    
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
        profileImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 180 / 2
            $0.clipsToBounds = true
            addSubview($0)
        }
        
        fullnameLabel.do {
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textAlignment = .center
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.size.equalTo(180)
        }
        
        fullnameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(10)
            $0.left.equalTo(profileImageView)
        }
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        if let url = viewModel.profileImageURL {
            profileImageView.kf.setImage(
                with: url, options: [.processor(DefaultImageProcessor.default)]
            )
        }
        
        fullnameLabel.text = viewModel.fullname
    }
}
