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
    
    let profileImageView = UIImageView()
    private var postsLabel = UILabel()
    private var followersLabel = UILabel()
    private var genealogy = UILabel()
    private let userInfoStackView = UIStackView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        profileImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 180 / 2
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
            addSubview($0)
        }
        
        postsLabel.do {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.attributedText = attributedStatusText(value: 999, label: "게시물")
        }
        
        followersLabel.do {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.attributedText = attributedStatusText(value: 999, label: "팔로워")
        }
        
        genealogy.do {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.attributedText = attributedStatusText(value: 999, label: "족보")
        }
        
        userInfoStackView.do {
            $0.addArrangedSubview(postsLabel)
            $0.addArrangedSubview(followersLabel)
            $0.addArrangedSubview(genealogy)
            $0.distribution = .fillEqually
            $0.spacing = 0
            addSubview($0)
        }
        
        addDot(to: postsLabel)
        addDot(to: followersLabel)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.size.equalTo(180)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.centerX.equalTo(profileImageView)
            $0.top.equalTo(profileImageView.snp.bottom).offset(10)
            $0.left.lessThanOrEqualTo(20)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        profileImageView.addGestureRecognizer(tap)
    }
    
    @objc private func handleImageTap() {
        let fullScreen = FullScreenController()
        fullScreen.modalTransitionStyle = .crossDissolve
        fullScreen.modalPresentationStyle = .overFullScreen
        fullScreen.image = profileImageView.image
        window?.rootViewController?.present(fullScreen, animated: true)
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        if let url = viewModel.profileImageURL {
            profileImageView.kf.setImage(
                with: url, options: [.processor(DefaultImageProcessor.default)]
            )
        }
    }
    
    private func attributedStatusText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(
            string: "\(value)\n",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 14)]
        )
        attributedText.append(
            NSAttributedString(
                string: label,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.lightGray
                ]
            )
        )
        return attributedText
    }
    
    private func addDot(to label: UILabel) {
        let dot = UIView()
        dot.backgroundColor = .lightGray
        dot.layer.cornerRadius = 1
        dot.clipsToBounds = true
        addSubview(dot)
        
        dot.snp.makeConstraints {
            $0.centerY.equalTo(userInfoStackView)
            $0.left.equalTo(label.snp.right)
            $0.size.equalTo(2)
        }
    }
}
