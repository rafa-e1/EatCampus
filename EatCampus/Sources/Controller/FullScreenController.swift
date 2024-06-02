//
//  FullScreenController.swift
//  EatCampus
//
//  Created by RAFA on 6/2/24.
//

import UIKit

import SnapKit
import Then

final class FullScreenController: UIViewController {
    
    // MARK: - Properties
    
    private let fullScreenView = FullScreenView()
    
    var image: UIImage? {
        didSet {
            fullScreenView.imageView.image = image
        }
    }
    
    override func loadView() {
        view = fullScreenView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonActions()
        setupGestures()
    }
    
    // MARK: - Actions
    
    private func setButtonActions() {
        fullScreenView.closeButton.addTarget(
            self,
            action: #selector(dismissFullScreen),
            for: .touchUpInside
        )
    }
    
    @objc private func dismissFullScreen() {
        dismiss(animated: true)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        fullScreenView.imageView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handleTapGesture() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            fullScreenView.imageView.transform = CGAffineTransform(
                translationX: 0,
                y: translation.y
            )
        case .ended:
            if abs(translation.y) > 100 || abs(velocity.y) > 500 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.fullScreenView.imageView.transform = .identity
                })
            }
        default:
            break
        }
    }
}
