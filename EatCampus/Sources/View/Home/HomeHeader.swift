//
//  HomeHeader.swift
//  EatCampus
//
//  Created by RAFA on 6/2/24.
//

import UIKit

final class HomeHeader: UIView {
    
    // MARK: - Properties
    
    let searchBarButton = UIButton(type: .custom)
    let tabMenu = UISegmentedControl(items: ["전체보기", "카테고리","내 족보"])
    let underlineView = UIView()
    
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
        configureSearchButton()
        configureTabMenu()
        configureUnderline()
    }
    
    private func configureSearchButton() {
        var config = UIButton.Configuration.gray()
        config.title = "검색"
        config.image = UIImage(systemName: "magnifyingglass")?
            .applyingSymbolConfiguration(
                UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
            )
        config.imagePlacement = .leading
        config.imagePadding = 5
        config.attributedTitle = AttributedString(
            NSAttributedString(
                string: "검색",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .regular),
                    .foregroundColor: UIColor.systemGray
                ]
            )
        )
        
        searchBarButton.setTitleColor(.systemRed, for: .selected)
        searchBarButton.configuration = config
        searchBarButton.tintColor = .systemGray
        searchBarButton.contentHorizontalAlignment = .leading
        addSubview(searchBarButton)
    }
    
    private func configureTabMenu() {
        configureTabMenuAppearance()
        tabMenu.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        addSubview(tabMenu)
    }
    
    private func configureTabMenuAppearance() {
        tabMenu.selectedSegmentTintColor = .clear
        tabMenu.selectedSegmentIndex = 0
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        
        tabMenu.setTitleTextAttributes(normalTextAttributes, for: .normal)
        tabMenu.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        tabMenu.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        tabMenu.setDividerImage(
            UIImage(),
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: .default
        )
    }
    
    private func configureUnderline() {
        underlineView.backgroundColor = .tabBarItemTint
        addSubview(underlineView)
        
        underlineView.frame = CGRect(
            x: CGFloat(tabMenu.selectedSegmentIndex) *
               (tabMenu.bounds.width / CGFloat(tabMenu.numberOfSegments)),
            y: tabMenu.bounds.height - 2,
            width: tabMenu.bounds.width / CGFloat(tabMenu.numberOfSegments),
            height: 2
        )
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        searchBarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(20)
            $0.height.equalTo(40)
        }
        
        tabMenu.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(searchBarButton.snp.bottom).offset(10)
            $0.left.equalTo(searchBarButton)
            $0.height.equalTo(45)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(tabMenu.snp.bottom)
            $0.left.equalTo(tabMenu.snp.left).offset(
                CGFloat(tabMenu.selectedSegmentIndex) *
                (tabMenu.bounds.width / CGFloat(tabMenu.numberOfSegments))
            )
            $0.width.equalTo(tabMenu.snp.width).dividedBy(tabMenu.numberOfSegments)
            $0.height.equalTo(2)
        }
    }
    
    // MARK: - Actions
    
    @objc private func segmentedControlDidChange(_ sender: UISegmentedControl) {
        Vibration.soft.vibrate()
        UIView.animate(withDuration: 0.25) {
            self.underlineView.snp.updateConstraints {
                $0.left.equalTo(self.tabMenu.snp.left).offset(
                    CGFloat(sender.selectedSegmentIndex) *
                    (self.tabMenu.bounds.width / CGFloat(self.tabMenu.numberOfSegments))
                )
            }
            self.layoutIfNeeded()
        }
    }
}
