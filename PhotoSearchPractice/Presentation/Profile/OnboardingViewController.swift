//
//  OnboardingViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {

    private let button = UIButton()
    
    override func configHierarchy() {
        view.backgroundColor = .darkGray
        view.addSubview(button)
    }
    
    override func configLayout() {
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
    }
    
    override func configView() {
        button.do {
            var config = UIButton.Configuration.plain()
            config.title = "시작하기"
            config.baseForegroundColor = .darkGray
            config.cornerStyle = .capsule
            config.background.backgroundColor = .white
            
            $0.configuration = config
            $0.addAction(UIAction(handler: { _ in
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
                    // early exit
                    return
                }
                window.rootViewController = UINavigationController(rootViewController: ProfileViewController())
                window.makeKeyAndVisible()
                UserDefaultsManager.shared.isOnboarded = true
            }), for: .touchUpInside)
        }
    }
}
