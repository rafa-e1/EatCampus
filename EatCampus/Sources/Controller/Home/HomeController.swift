//
//  HomeController.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import SnapKit

private let reuseIdentifier = "HomeCell"

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let homeHeader = HomeHeader()
    private let refreshControl = UIRefreshControl()
    private let collectionView: UICollectionView
    
    // MARK: - Lifecycle
    
    init() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setButtonActions()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(homeHeader)
        view.addSubview(collectionView)
        
        refreshControl.tintColor = .systemYellow
        collectionView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        homeHeader.snp.makeConstraints {
            $0.centerX.left.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(107)
        }
        
        collectionView.snp.makeConstraints {
            $0.centerX.left.equalToSuperview()
            $0.top.equalTo(homeHeader.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    private func setButtonActions() {
        homeHeader.searchBarButton.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func searchButtonTapped() {
        let controller = MapController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = ""
    }
    
    @objc private func refreshData() {
        Vibration.success.vibrate()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Helpers
    
    private func configureCollectionView() {
        collectionView.scrollIndicatorInsets = .init(top: -2, left: 0, bottom: 0, right: 0)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
}

// MARK: - UICollectionViewDataSource

extension HomeController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? HomeCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .skeleton
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = view.bounds.width
        return CGSize(width: width, height: width)
    }
}
